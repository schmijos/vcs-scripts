# vcs-scripts
Some version control scripts we use

## list_large_files.rb

Lists files of the commit history which are larger than a certain threshold.
For example the following lists every file larger than 10mb and its commits beginning from the *HEAD* ref:

    ./list_large_files.rb HEAD 10
    
For the default Renuo use case (finding files in repos which are more than 50mb) you can run it directly downloaded from here:

    curl -s https://raw.githubusercontent.com/renuo/vcs-scripts/master/list_large_files.rb | ruby

## list_large_files.sh

This script consists of the following one-line using only git tools. It lists the 5 largest files in the history.
Appearently it shows files which aren't shown by the ruby script above (?).

    join -o "1.1 1.2 2.3" <(git rev-list --objects --all | sort) <(git verify-pack -v objects/pack/*.idx | sort -k3 -n | tail -5 | sort) | sort -k3 -n
