#!/bin/bash
# Usage: svnArchive.sh URL [username]

# Subversion is needed
command -v svn >/dev/null 2>&1 || { echo >&2 "I require Subversion but it's not installed. Aborting."; exit 1; }

# Repo URL is needed
if [ -z "$1" ]; then
    echo "Please specify repo URL"
fi

# Extract and save the repo name
repo=$(echo $1 | grep -oP '[^/\n]+$')

# In case the check out is needed
#if [ -z "$2" ]; then
#    svn co $1 $repo
#else
#    svn co --username $2 $1 $repo
#fi

# Export the repo (--force  to replace the directory if it exists)
if [ -z "$2" ]; then
    svn export --force $1 $repo
else
    svn export --username --force  $2 $1 $repo
fi

# Make the archive
myDate=$(date "+%Y%m%d%H%M%S")
echo creating $repo-$myDate.tar.gz
tar czf $repo-$myDate.tar.gz $repo

# Cleanup
rm -rf $repo
