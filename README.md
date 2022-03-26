# My arch linux system maintenance
**Disclaimer:** This was created for personal documentation of my setup to make my setup more reproducible. Do not use this as a guide.

A collection of useful commands to keep arch linux clean inspired by a video of [eflinux](https://www.youtube.com/watch?v=wwSkFi3h2nI) and the arch wiki on [system maintenance](https://wiki.archlinux.org/title/System_maintenance).

## 1. Check for failed systemd services
```sh
systemctl --failed
```

## 2. Look through log files
```sh
sudo journalctl -p 3 -xb
```

## 3. Update system
```sh
sudo pacman -Syyu    # for main repositories only
paru -Syyu           # for all repositories
```
## 4. Check pacman cache
The  cache where packages are stored, both installed and uninstalled. It is **not** advised to delete the full pacman cache. Only delete packages from the cache that are not installed.
To delete the cached packages that are not currently installed use
```sh
sudo pacman -Sc     # for main repositories only
paru -Sc            # for all repositories
```

## 5. Clean unwanted dependencies
```sh
pacman -Qdt                 # to list dep.
sudo pacman -Rsn $(pacman -Qdtq) # remove them
paru --clean                # this works as well
```

## 6. Uninstall orphaned packages
```sh
pacman -Qtdq                # list orphans
sudo pacman -Rns $(pacman -Qdtq)    # remove them
```

## 7. Clean .cache
```sh
du -sh .cache   # show cache size
rm -rf .cache/* # delete all inside .cache
du -sh .cache   # recheck size
```

## 8. Check .config
Make sure that only unneeded files are deleted here.
```sh
du -sh .config/
```

## 9. Check journal
Different options for the journalctl flat --vacuum are listed in the journalctl manpage.
```sh
du -sh //var/log/journal/ # show journal size
sudo journalctl --vacuum-time=2weeks # cleans all older than 2 weeks
```

## 10. Keep mirror list fresh
Make sure the correct countries are listed in `sudo vim /etc/xdg/reflector/reflector.conf`. To automatically refresh mirrors once a week use
```sh
sudo systemctl enable reflector.service reflector.timer
sudo systemctl start reflector.service reflector.timer
```
To refresh mirrors now use
```sh
sudo systemctl start reflector.service
```
To check the generated mirrorlist use 
```sh
cat /etc/pacman.d/mirrorlist
```

## 11. In case of unbootable system
Hit `ctrl alt f2` to drop to the terminal, then login and enter `timeshift --restore` to bring up a list of restorepoints to choose from.

## Check if cronie runs facilitate cronjobs
```sh
sudo systemctl status cronie.service
```

## Check if timeshift snapshots are performed as planned
... and compare the output to the GUI output to verify
```sh
sudo timeshift --check --scripted
```