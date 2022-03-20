# Arch linux system maintenance
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
sudo pacman -Syu    # for main repositories only
paru -Syu           # for all repositories
```
## 4. Check pacman cache
The  cache where packages are stored, both installed and uninstalled.
To delete the cached packages that are not currently installed use
```sh
sudo pacman -Sc     # for main repositories only
paru -Sc            # for all repositories
```
A more agressive approach deletes all chached packages, installed and uninstalled. 
```sh
sudo pacman -Scc    # main repos
paru -Scc           # all repos
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
```sh
sudo reflector -c Germany -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```