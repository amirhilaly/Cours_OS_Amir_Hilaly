# 1 – Programmes et processus
## A) Run then kill:
```
sleep 1000
```

**Deuxieme terminal:**
```
ps -e | grep sleep
kill 1423
```
(le pid de sleep était de 1423)  

## B)
```
amimir@vbox:~/test/dawa$ sleep 1000 &

amimir@vbox:~/test/dawa$ jobs -l
[1]+ 37756 Running                 sleep 1000 &
```
## C)
Pour find sleep:
```
sudo find / -name sleep
/usr/bin/sleep
```
Et find .bashrc:
```
sudo find / -name .bashrc
```

Ce qui nous donne:
```
/etc/skel/.bashrc
/root/.bashrc
/home/papier_alu/.bashrc
/home/amimir/.bashrc
```

## D)
```
amimir@vbox:~$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
amimir@vbox:~$ which ls
/usr/bin/ls
amimir@vbox:~$ which sleep
/usr/bin/sleep
amimir@vbox:~$ which ssh
/usr/bin/ssh
amimir@vbox:~$ which ping
/usr/bin/ping
```

# 2 – Paquets

## Installer firefox:
```
root@vbox:/home/amimir# apt install firefox
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package firefox is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
However the following packages replace it:
  gnome-browser-connector

E: Package 'firefox' has no installation candidate
```
Ici j’ai un message d’erreur car on a deja firefox d’installer :p


## Utiliser une commande pour lancer firefox
```
amimir@vbox:~/test/dawa$ firefox
amimir@vbox:~/test/dawa$ which firefox
/usr/bin/firefox
```

## Mais aussi déterminer…
```
root@vbox:/home/amimir# cat /etc/apt/sources.list
#deb cdrom:[Debian GNU/Linux 12.7.0 _Bookworm_ - Official amd64 NETINST with firmware 20240831-10:38]/ bookworm contrib main non-free-firmware

deb http://deb.debian.org/debian/ bookworm main non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware
```



