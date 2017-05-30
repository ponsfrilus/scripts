#!/bin/bash
# Dump a SVN repository with all branches and history, then push all to a
# newly created GIT repository.
echo "Automatisation de migration svn2git"
die () {
    echo >&2 "$@"
    exit 1
}

echo "usage ./svn2git.sh SVNREPO GITREPO"
[ "$#" -eq 2 ] || die "2 argument required, $# provided"


#SVNREPO=www
#GITREPO=leniwww

SVNREPO=$1
GITREPO=$2

echo "== Migration de $SVNREPO =="
echo ""
echo "création du repertoire git"
mkdir $SVNREPO\_git
echo "enter the git directory"
cd $SVNREPO\_git

echo "Read https://github.com/nirvdrum/svn2git for details!"
## Default layout /branches /tags /trunk
#svn2git -v  https://lenisvn.epfl.ch/svn/$SVNREPO --username nbo --authors /home/nborboen/Documents/svn_authors_file.txt --metadata
svn2git -v  https://lenisvn.epfl.ch/svn/$SVNREPO --username nbo --authors /home/nborboen/Documents/svn_authors_file.txt --metadata --trunk /trunk --branches /branches --tags /tags

## NOTE: --rootistrunk is not working with httpS:// repos
## svn2git -v https://lenisvn.epfl.ch/svn/$SVNREPO --username=nbo --authors /home/nborboen/Documents/svn_authors_file.txt --metadata --rootistrunk

## Use --trunk /  --nobranches --notags instead:
#svn2git -v https://lenisvn.epfl.ch/svn/$SVNREPO --trunk / --nobranches --notags --username=nbo --authors /home/nborboen/Documents/svn_authors_file.txt --metadata

## For sub-direcotry in USERS
#svn2git -v https://lenisvn.epfl.ch/svn/users/$SVNREPO/ --notrunk --nobranches --notags --username=nbo --authors /home/nborboen/Documents/svn_authors_file.txt --metadata --no-minimize-url
#echo "For Users, use
#cd $SVNREPO\_git
#git branch -D git-svn
#git push origin --delete git-svn
#git push --all"
#echo ""


echo "repo author"
git config user.name "Nicolas Borboën"
git config user.email "nicolas.borboen@epfl.ch"

echo "repo initialized..."
git log
echo "... listing branches"
git branch -r
git branch -a

echo "
## Création d'un fichier dans les répertoire vides
find . -type d -empty -exec touch {}/.gitignore \;
git add *
git commit -a .m "Empty dir added"

git branch -v
git checkout BranchName
// et refaire le find pour chaque branche //
git status
git push --all
"



echo "Push des modifications"
git remote add origin https://nborboen@git.epfl.ch/repo/$GITREPO.git
git push --all
git push --tags

echo "== Archivage =="
echo "Use sh svn_archive.sh $SVNREPO $GITREPO"

exit 0
