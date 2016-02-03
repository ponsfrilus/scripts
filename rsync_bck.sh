#!/bin/bash
# http://www.thegeekstuff.com/2011/01/rsync-exclude-files-and-folders/
# http://www.bobulous.org.uk/misc/rsync-backup.html
# http://stackoverflow.com/questions/4493525/rsync-what-means-the-f-on-rsync-logs

DEST='/media/nborboen/6139-64617/BACKUP/'
## Some important file
# /home/nborboen/.bash_aliases
# /home/nborboen/.bash_history
# /home/nborboen/.bashrc
# /home/nborboen/.zshrc
# /home/nborboen/.face
# /home/nborboen/.smbcredentials
# /home/nborboen/.vimrc
# /home/nborboen/.zsh_history
# /etc/fstab
# /etc/hosts
# /etc/php5/apache2/php.ini
# /home/nborboen/.ssh
# /etc/apache2/sites-available/
# /etc/ssmtp/
# /etc/php5/mods-available/
rsync -Rav `cat rsync_files_list.txt` /media/nborboen/6139-64616/FILESBackup/ 

## Home and www 
rsync -R --archive --verbose --human-readable --itemize-changes --progress \
--delete --delete-excluded \
--exclude='/.gvfs/' --exclude='node_modules*' --exclude='.meteor*' --exclude='/.Trash-1000/' \
--exclude='/.thumbnails/' --exclude='__MACOSX*' --exclude='*.swp' --exclude='.synkron.syncdb' \
/home/nborboen/Calibre\ Library/ \
/home/nborboen/Desktop/ \
/home/nborboen/dev/ \
/home/nborboen/Documents/ \
/home/nborboen/Pictures/ \
/home/nborboen/programs/ \
/home/nborboen/.ssh/ \
/home/nborboen/.mozilla/firefox/k1yzvfte.default/searchplugins/  \
/var/www/  \
$DEST 2>&1 | tee /home/nborboen/rsync-output.txt


















