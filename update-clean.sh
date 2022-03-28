#!/bin/sh
# A collection of tasks to keep pacman up and running.

# Refresh mirrors
echo $'\e[1;32mRefreshing mirrors ...\e[0m'
sudo systemctl start reflector.service

# Update system
echo $'\e[1;32mUpdating system ...\e[0m'
sleep 2s

echo # to make a new line
echo $'\e[1;32mPacman\e[0m'
sudo pacman -Syu

echo # to make a new line
echo $'\e[1;32mParu\e[0m'
paru -Syu

echo # to make a new line
echo $'\e[1;32mFlatpak\e[0m'
flatpak update

echo # to make a new line
echo $'\e[1;32mConda\e[0m'
conda update -n base -c defaults conda

# Delete non-installed cached packages
echo # to make a new line
echo $'\e[1;32mDeleting uninstalled packages from cache ...\e[0m'
sudo pacman -Sc
paru -Sc 

# Clean unused dependencies
echo # to make a new line
echo $'\e[1;32mCleaning unused dependencies ...\e[0m'
sudo pacman -Rsn $(pacman -Qdtq) 
paru --clean

echo $'\e[1;32mFinished!\e[0m'