#!/bin/bash
# Fetching and installing the git repo github.com/esnalabu/homedir.com

tmpdir="/tmp/homedirtmp"
backupdir="$HOME/homedir_backup"
installdir="$HOME"
gitinstalled="unknown"

# Check if git is installed
if git --version > /dev/null 2>&1; then
    echo "You got git installed. Good for you!"
    gitinstalled=true
else
    echo "You need to install git. Do it now?"
    read installgit
    if [ $installgit == "y" ]; then
        sudo apt-get install git && gitinstalled=true
    else
        echo "Git not installed, aborting."
        exit 1
    fi
fi

# check if there is a git repo in $installdir
if [ -d $installdir/.git  ]; then
    echo "There is a git repo in $installdir, aborting."
fi



if [ $gitinstalled = "true" ]; then
# Make tmp dir, clone repo
    mkdir $tmpdir
    git clone https://github.com/esnalabu/homedir $tmpdir
    files=$(cat $tmpdir/.gitignore | sed 's/[!*]//')
else
    echo "Git not installed, aborting."
fi

# Continue?
if [ $gitinstalled = "true" ]; then
    echo "Do you want to replace these files(y/n):"
    echo "$files"
    read replacefiles
    if [ $replacefiles == "y" ]; then
 # Backup files that will be overwritten by homedir.git
        mkdir $backupdir
        for file in $files; do
            echo "Backing up this file: $file"
            cp $file $backupdir && echo -e "\nFile have been backed up to $backupdir."
        done
# replace the files
        cp -r $tmpdir/{,.??}* $installdir && echo "Files have been replaced."
    fi
fi
