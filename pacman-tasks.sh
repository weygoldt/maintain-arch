#!/bin/sh
# A collection of tasks to keep pacman up and running.

# Update system
echo $'\e[1;32mUpdating system ...\e[0m'
sudo pacman -Syu
paru -Syu
flatpak update

# Delete non-installed cached packages
echo $'\e[1;32mDeleting uninstalled packages from cache ...\e[0m'
sudo pacman -Sc
paru -Sc 

# Clean unused dependencies
echo $'\e[1;32mCleaning unused dependencies ...\e[0m'
sudo pacman -Rsn $(pacman -Qdtq) 
paru --clean

# Refresh mirrors
echo $'\e[1;32mRefreshing mirrors ...\e[0m'
sudo reflector -c Germany -a 6 --sort rate --save /etc/pacman.d/mirrorlist
