#!/bin/bash
# Export the full repository, make a README file, make a archive with the
# contents, add the README and the archive to the repository.
die () {
    echo >&2 "$@"
    exit 1
}

echo "usage ./svn_archive.sh SVNREPO GITREPO user"
[ "$#" -ge 2 ] || die "2 or 3 arguments required, $# provided"


#SVNREPO=www
#GITREPO=leniwww

SVNREPO=$1
GITREPO=$2

echo $3
if [ "$3" = "y" ] || [ "$3" = "Y" ] || [ "$3" = "yes" ] || [ "$3" = "Yes" ]; then
	echo "User mode :"
	USERS="users/"
fi

echo "== Archivage =="
svn co https://lenisvn.epfl.ch/svn/$USERS$SVNREPO $SVNREPO\_svn
svn export https://lenisvn.epfl.ch/svn/$USERS$SVNREPO $SVNREPO\_svn_export
tar -jcvf $SVNREPO.tar.bz2 $SVNREPO\_svn_export/
cd $SVNREPO\_svn
svn del *
svn ci . -m "moved to git.epfl.ch"
cd ..
mv $SVNREPO.tar.bz2 $SVNREPO\_svn
cd $SVNREPO\_svn
DATE=`date +%y-%m-%d\ %H:%M:%S`
#touch README.txt
cat > README.txt <<EOF
-----------------------------
$DATE nicolas.borboen@epfl.ch

This SVN repo has been moved to GIT!
====================================

The repository URL is :
 https://user@git.epfl.ch/repo/$GITREPO.git

To clone the repository, use the following command :
 git clone https://user@git.epfl.ch/repo/$GITREPO.git

For authentification, use your GASPAR credentials.
-----------------------------
EOF

more README.txt

svn add README.txt $SVNREPO\.tar.bz2
svn ci README.txt $SVNREPO\.tar.bz2 -m "Archive - moved to git.epfl.ch"

echo "You can now remove $SVNREPO\_svn_export and  $SVNREPO\_svn"

exit 0
