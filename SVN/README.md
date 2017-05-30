# Subversion Tools

## List of files

### `svn_archive.sh`

  * `./svn_archive.sh SVNREPO GITREPO user`  
  * Export the full repository, make a README file, make a archive with the
    contents, add the README and the archive to the repository.

### `svn2git.sh`

  * `./svn2git.sh SVNREPO GITREPO`
  * Dump a SVN repository with all branches and history, then push all to a
    newly created GIT repository.  
    Use the `svn_authors_file.txt` to match the authors.

### `svnArchive.sh`

  * `./svnArchive.sh URL [username]`
  * Export a SVN repository and create an archive.
