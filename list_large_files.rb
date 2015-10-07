#!/usr/bin/env ruby -w
# source: http://stackoverflow.com/a/7945209/430418

head, treshold = ARGV

head ||= 'HEAD'
treshold ||= '50'

Megabyte = 1000 ** 2
treshold = treshold.to_f * Megabyte

big_files = {}

IO.popen("git rev-list #{head}", 'r') do |rev_list|
  rev_list.each_line do |commit|
    commit.chomp!
    for object in `git ls-tree -zrl #{commit}`.split("\0")
      bits, type, sha, size, path = object.split(/\s+/, 5)
      size = size.to_i
      big_files[sha] = [path, size, commit] if size >= treshold
    end
  end
end

big_files.each do |sha, (path, size, commit)|
  where = `git show -s #{commit} --format='%h: %cr'`.chomp
  puts "%4.1fM\t%s\t(%s)" % [size.to_f / Megabyte, path, where]
end
