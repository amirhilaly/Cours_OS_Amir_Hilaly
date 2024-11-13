# 1. Jouer avec la commande ps

### Affichez les processus bash

- une commande ps puis vous filtrez la sortie pour afficher que les bash

```
amimir@vbox:~$ ps -ef | grep bash
amimir       953     856  0 13:56 pts/0    00:00:00 bash
amimir      1423    1419  0 13:56 pts/1    00:00:00 -bash
amimir      1871    1867  0 18:14 pts/2    00:00:00 -bash
amimir      2060    1871 33 19:24 pts/2    00:00:00 grep bash
```



### Affichez tous les processus lancés par votre utilisateur

- uniquement ceux qui sont lancés par votre utilisateur, pas ceux lancés par root ou autres

```
amimir@vbox:~$ ps -ef | grep "^amimir"
amimir       706       1  0 13:56 ?        00:00:00 /lib/systemd/systemd --user
amimir       707     706  0 13:56 ?        00:00:00 (sd-pam)
amimir       722     706  0 13:56 ?        00:00:00 /usr/bin/pulseaudio --daemonize=no --log-target=journal
amimir       724     706  0 13:56 ?        00:00:00 /usr/bin/gnome-keyring-daemon --foreground --components=pkcs11,secrets --control-directory=/run/user/1000/keyring
amimir       728     706  0 13:56 ?        00:00:02 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
amimir       732     701  0 13:56 ?        00:00:00 xfce4-session
amimir       780     732  0 13:56 ?        00:00:00 /usr/bin/ssh-agent x-session-manager
amimir       790     706  0 13:56 ?        00:00:00 /usr/libexec/at-spi-bus-launcher
amimir       796     790  0 13:56 ?        00:00:00 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 11 --address=unix:path=/run/user/1000/at-spi/bus_0
amimir       806     706  0 13:56 ?        00:00:00 /usr/libexec/at-spi2-registryd --use-gnome-session
amimir       816     706  0 13:56 ?        00:00:00 /usr/bin/gpg-agent --supervised
amimir       818     732  0 13:56 ?        00:00:00 xfwm4 --display :0.0 --sm-client-id 22cc958ad-2b38-40d3-83fb-36fc7d0fda5c
amimir       821     706  0 13:56 ?        00:00:00 /usr/libexec/gvfsd
amimir       833     732  0 13:56 ?        00:00:00 xfsettingsd --display :0.0 --sm-client-id 27ddebbd7-0e0d-424a-90bb-9ee1cbb4f9e6
amimir       842     732  0 13:56 ?        00:00:01 xfce4-panel --display :0.0 --sm-client-id 2f52acc2f-eac4-4019-bd50-2ac17f8971d6
amimir       846     732  0 13:56 ?        00:00:00 Thunar --sm-client-id 2187d85a7-591b-446b-bd56-02c6ba3d6bdd --daemon
amimir       851     732  0 13:56 ?        00:00:00 xfdesktop --display :0.0 --sm-client-id 279e511e3-5d15-4235-bed9-7ec1b19f9527
amimir       856     732  0 13:56 ?        00:00:00 xfce4-terminal --geometry=80x24 --display :0.0 --role=xfce4-terminal-1730890950-602239618 --show-menubar --show-borders --hide-toolbar --active-tab --working-directory /home/amimir --sm-client-id 24647b098-8b29-4f31-91b5-a54feb6f04b8
amimir       857     732  0 13:56 ?        00:00:00 xfce4-power-manager --restart --sm-client-id 2c4818121-b7bf-4621-855d-4a3432871e6f
amimir       858     842  0 13:56 ?        00:00:00 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libsystray.so 6 16777228 systray Status Tray Plugin Provides status notifier items (application indicators) and legacy systray items
amimir       861     842  0 13:56 ?        00:00:06 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libpulseaudio-plugin.so 8 16777229 pulseaudio PulseAudio Plugin Adjust the audio volume of the PulseAudio sound system
amimir       863     842  0 13:56 ?        00:00:01 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libxfce4powermanager.so 9 16777230 power-manager-plugin Power Manager Plugin Display the battery levels of your devices and control the brightness of your display
amimir       864     842  0 13:56 ?        00:00:00 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libnotification-plugin.so 10 16777231 notification-plugin Notification Plugin Notification plugin for the Xfce panel
amimir       867     706  0 13:56 ?        00:00:00 /usr/libexec/gvfs-udisks2-volume-monitor
amimir       883     821  0 13:56 ?        00:00:00 /usr/libexec/gvfsd-trash --spawner :1.14 /org/gtk/gvfs/exec_spaw/0
amimir       893     706  0 13:56 ?        00:00:00 /usr/libexec/gvfsd-metadata
amimir       896     706  0 13:56 ?        00:00:00 /usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd
amimir       908     842  0 13:56 ?        00:00:00 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libactions.so 14 16777232 actions Action Buttons Log out, lock or other system actions
amimir       953     856  0 13:56 pts/0    00:00:00 bash
amimir       960     732  0 13:56 ?        00:00:00 /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1
amimir       961     732  0 13:56 ?        00:00:00 /usr/bin/python3 /usr/share/system-config-printer/applet.py
amimir       962     732  0 13:56 ?        00:00:00 nm-applet
amimir       969     732  0 13:56 ?        00:00:00 light-locker
amimir       971     732  0 13:56 ?        00:00:00 xiccd
amimir      1014     706  0 13:56 ?        00:00:00 /usr/libexec/dconf-service
amimir      1196     706  0 13:56 ?        00:00:00 /usr/libexec/xdg-desktop-portal
amimir      1200     706  0 13:56 ?        00:00:00 /usr/libexec/xdg-document-portal
amimir      1203     706  0 13:56 ?        00:00:00 /usr/libexec/xdg-permission-store
amimir      1216     706  0 13:56 ?        00:00:00 /usr/libexec/xdg-desktop-portal-gtk
amimir      1419    1408  0 13:56 ?        00:00:01 sshd: amimir@pts/1
amimir      1423    1419  0 13:56 pts/1    00:00:00 -bash
amimir      1867    1858  0 18:14 ?        00:00:00 sshd: amimir@pts/2
amimir      1871    1867  0 18:14 pts/2    00:00:00 -bash
amimir      2085    1871 99 19:30 pts/2    00:00:00 ps -ef
amimir      2086    1871 33 19:30 pts/2    00:00:00 grep ^amimir
```


### Affichez le top 5 des processus qui utilisent le plus de RAM

- uniquement 5 lignes doivent s'afficher et elles ne contiennent QUE le nom du processus et la RAM utilisée

```
amimir@vbox:~$ ps aux --sort=-%mem | head -n 6 | awk '{print $11, $4}'
COMMAND %MEM
/usr/sbin/lightdm-gtk-greeter 7.0
/usr/lib/xorg/Xorg 6.1
xfwm4 6.1
/usr/lib/xorg/Xorg 4.6
xfdesktop 3.8
```
Ici, -aux nous permet d'afficher toutes sortes d'infos comme la ram utilisé ce que -ef ne fait pas, --sort=-%mem nous permet de filtrer selon la mémoire utilisé du plus grand au plus petit, head -n 6 ne prend que les 5 premiers resultats et awk trie pour ne resortir que les fields 11 et 4 puisque c'est eux que l'on cherche (le processus + la taille de mémoire utilisé)


### Affichez le PID du processus du service SSH

- le nom du programme c'est sshd

```
amimir@vbox:~$ ps -ef | grep sshd | head -n 1
root         613       1  0 13:55 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
```
Oui j'utilise head -n 1 car, vue que c'est lui le parent, c'est le premier de la liste, logique! meow


### Affichez le nom du processus avec l'identifiant le plus petit

- votre commande doit afficher le processus qui a le plus petit identifiant sans le connaître à l'avance


- une seule ligne doit être affichée
la commande doit tout le temps fonctionner quoi !

```
amimir@vbox:~$ ps -ef --sort=pid | head -n 2
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 13:55 ?        00:00:01 /sbin/init
```


## 1. Parent, enfant, et meurtre

### Déterminer le PID de votre shell actuel

- quand on ouvre un terminal sous Linux, généralement, le shell c'est bash

- donc déterminez le PID du processus bash dans lequel vous tapez des commandes

- n'affichez qu'une seule ligne

```
amimir@vbox:~$ echo $$
1871
```
### Déterminer le PPID de votre shell actuel

- le PPID c'est pour Parent PID : l'identifiant du processus parent
avec une commande ps et des options usuelles, l'info va sortir
n'affichez qu'une seule ligne
```
amimir@vbox:~$ ps -ef | grep 885 | head -n 1
amimir       885     883  0 08:17 pts/0    00:00:00 -bash
```  
le ppid c'est 883 (oui j'ai changer de bash c'est le jour d'après lol)

### Déterminer le nom de ce processus

- donc, votre bash est l'enfant d'un processus : lequel ?
vous venez de repérer son PID juste avant, facile de repérer son nom maintenant
n'affichez qu'une seule ligne
```
amimir@vbox:~$ ps -ef | grep 883 | head -n 1
amimir       883     850  0 08:17 ?        00:00:00 sshd: amimir@pts/0
```
###  Lancer un processus sleep 9999 en tâche de fond

- avec le caractère & comme au TP précédent
déterminer avec une commande ps son PID et son PPID

- vous n'afficherez qu'une seule ligne


- vous devriez constater que son PPID, c'est votre bash
```
amimir@vbox:~$ sleep 9999 &
[1] 2012
amimir@vbox:~$ ps -ef | grep sleep | head -n 1
amimir      2012     885  0 09:02 pts/0    00:00:00 sleep 9999
```

### Fermez votre session SSH

- genre complètement déconnectez-vous de vos sessions SSH
puis reconnecte-toi avec une nouvelle connexion SSH
est-ce que le processus sleep lancé en tâche de fond s'exécute toujours ?
prouver que oui ou non en une seule commande

```
amimir@vbox:~$ exit
logout
Connection to 192.168.163.10 closed.
PS C:\Users\amoum> ssh amimir@192.168.163.10
amimir@192.168.163.10's password:
Linux vbox 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 (2024-09-30) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Nov 13 08:17:44 2024 from 192.168.163.1
amimir@vbox:~$ ps -ef | grep sleep | head -n 1
amimir      2012       1  0 09:02 ?        00:00:00 sleep 9999
```