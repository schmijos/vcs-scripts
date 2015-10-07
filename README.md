# vcs-scripts
Some version control scripts we use

## list_large_files.rb

Lists files of the commit history which are larger than a certain threshold.
For example the following lists every file larger than 50mb and its commit.

    sh -c "$(curl -fsSL -H "Content-Type: text/plain" -X GET https://raw.githubusercontent.com/renuo/vcs-scripts/master/list_large_files.rb) HEAD 50"
