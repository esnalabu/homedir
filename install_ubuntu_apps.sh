#!/bin/bash
# Script for installing preferred apps for ubuntu
# run with sudo

applist="
    htop \
    vim \
    git \
    tmux \
    tree"

# Install applications?
echo "Install these apps using apt-get?"
echo $applist
read install_aptget
if [ $install_aptget == "y" ]; then
    sudo apt-get update
    sudo apt-get -y install $applist
fi    
