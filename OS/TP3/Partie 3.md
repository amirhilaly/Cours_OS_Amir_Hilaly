🌞 S'assurer que le service ssh est démarré

```
amimir@vbox:~$ systemctl status
● vbox
    State: running
    Units: 273 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Wed 2024-11-13 08:16:51 CET; 1h 11min ago
  systemd: 252.30-1~deb12u2
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─ModemManager.service
           │ │ └─455 /usr/sbin/ModemManager
           │ ├─NetworkManager.service
           │ │ └─443 /usr/sbin/NetworkManager --no-daemon
           │ ├─avahi-daemon.service
           │ │ ├─387 "avahi-daemon: running [vbox.local]"
           │ │ └─409 "avahi-daemon: chroot helper"
           │ ├─colord.service
           │ │ └─986 /usr/libexec/colord
           │ ├─cron.service
           │ │ └─390 /usr/sbin/cron -f
           │ ├─cups-browsed.service
           │ │ └─604 /usr/sbin/cups-browsed
           │ ├─cups.service
           │ │ ├─593 /usr/sbin/cupsd -l
           │ │ └─602 /usr/lib/cups/notifier/dbus dbus://
           │ ├─dbus.service
           │ │ └─391 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --syste>
```

🌞 Isolez la ligne qui indique le nom du programme lancé

```

```
🌞 Déterminer le port sur lequel écoute le service SSH
```
amimir@vbox:~$ sudo ss -lnpt | grep sshd
LISTEN 0      128    192.168.163.10:22        0.0.0.0:*    users:(("sshd",pid=2695,fd=3))
```

🌞 Consulter les logs du service SSH

```
amimir@vbox:~$ journalctl | grep sshd
Hint: You are currently not seeing messages from other users and the system.
      Users in groups 'adm', 'systemd-journal' can see all messages.
      Pass -q to turn off this notice.
Nov 07 11:40:39 vbox sshd[14443]: Received disconnect from 192.168.56.1 port 37077:11: disconnected by user
Nov 07 11:40:39 vbox sshd[14443]: Disconnected from user amimir 192.168.56.1 port 37077
Nov 07 12:02:59 vbox sshd[35680]: Received disconnect from 192.168.56.1 port 38728:11: disconnected by user
Nov 07 12:02:59 vbox sshd[35680]: Disconnected from user amimir 192.168.56.1 port 38728
Nov 13 09:23:36 vbox sshd[883]: Received disconnect from 192.168.163.1 port 12704:11: disconnected by user
Nov 13 09:23:36 vbox sshd[883]: Disconnected from user amimir 192.168.163.1 port 12704
Nov 13 09:50:09 vbox sudo[2628]:   amimir : TTY=pts/2 ; PWD=/etc/ssh ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:50:58 vbox sudo[2640]:   amimir : TTY=pts/2 ; PWD=/etc/ssh ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:52:00 vbox sudo[2668]:   amimir : TTY=pts/2 ; PWD=/etc/ssh ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:52:12 vbox sudo[2671]:   amimir : TTY=pts/2 ; PWD=/etc/ssh ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:52:42 vbox sudo[2682]:   amimir : TTY=pts/2 ; PWD=/etc/ssh ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:52:48 vbox sudo[2686]:   amimir : TTY=pts/2 ; PWD=/etc/ssh ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:56:05 vbox sudo[2729]:   amimir : TTY=pts/2 ; PWD=/etc/ssh ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:56:57 vbox sshd[2275]: Received disconnect from 192.168.163.1 port 12994:11: disconnected by user
Nov 13 09:56:57 vbox sshd[2275]: Disconnected from user amimir 192.168.163.1 port 12994
Nov 13 09:57:54 vbox sudo[2852]:   amimir : TTY=pts/2 ; PWD=/home/amimir ; USER=root ; COMMAND=/usr/bin/vi sshd_config
Nov 13 09:58:03 vbox sshd[2810]: Received disconnect from 192.168.163.1 port 13281:11: disconnected by user
Nov 13 09:58:03 vbox sshd[2810]: Disconnected from user amimir 192.168.163.1 port 13281
```

🌞 Identifier le fichier de configuration du serveur SSH

```
amimir@vbox:/etc$ ls -l | grep ssh
drwxr-xr-x  4 root root    4096 Nov 13 09:56 ssh
```
🌞 Modifier le fichier de conf

```
amimir@vbox:/etc$ echo $RANDOM
7551
amimir@vbox:/etc/ssh$ cat sshd_config | grep Port | head -n 1
Port 7551
```
🌞 Redémarrer le service

```
PS C:\Users\amoum> ssh amimir@192.168.163.10 -p 7551
amimir@192.168.163.10's password:
Linux vbox 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 (2024-09-30) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Nov 13 10:13:09 2024 from 192.168.163.1
```

🌞 Effectuer une connexion SSH sur le nouveau port

```
ssh amimir@192.168.163.10 -p 7551
amimir@192.168.163.10's password:
Linux vbox 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 (2024-09-30) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Nov 13 10:14:05 2024 from 192.168.163.1
amimir@vbox:~$
```


🌞 Trouver le fichier ssh.service
```
amimir@vbox:/etc/ssh$ sudo find / -name "ssh.service"
/etc/systemd/system/multi-user.target.wants/ssh.service
/usr/share/doc/avahi-daemon/examples/ssh.service
/usr/lib/systemd/system/ssh.service
```
🌞 Déterminer quel est le programme lancé

```
amimir@vbox:/usr/lib/systemd/system$ cat ssh.service | grep ExecStart=
ExecStart=/usr/sbin/sshd -D $SSHD_OPTS
```
🌞 Déterminer le dossier qui contient la commande python3

```
amimir@vbox:~$ which python3
/usr/bin/python3
```

🌞 Créez un fichier /etc/systemd/system/meow_web.service

```
amimir@vbox:/etc/systemd/system$ sudo touch meow_web.service
amimir@vbox:/etc/systemd/system$ sudo nano meow_web.service
amimir@vbox:/etc/systemd/system$ ls | grep meow_web.service
meow_web.service
```

🌞 Indiquez à l'OS que vous avez modifié les services

```
amimir@vbox:/etc/systemd/system$ sudo systemctl daemon-reload
```
🌞 Démarrez votre service

```
amimir@vbox:/etc/systemd/system$ sudo systemctl start meow_web
```
🌞 Assurez-vous que le service meow_web est actif

```
amimir@vbox:/etc/systemd/system$ systemctl status meow_web.service
● meow_web.service - Super serveur web MEOW
     Loaded: loaded (/etc/systemd/system/meow_web.service; disabled; preset: enabled)
     Active: active (running) since Wed 2024-11-13 10:44:39 CET; 5s ago
   Main PID: 3952 (python3)
      Tasks: 1 (limit: 1863)
     Memory: 9.4M
        CPU: 113ms
     CGroup: /system.slice/meow_web.service
             └─3952 /usr/bin/python3 -m http.server 8888
```
🌞 Déterminer le PID du processus Python en cours d'exécution
Le PID est 967
```
amimir@vbox:/etc/systemd/system$ ps -ef | grep python3
amimir       967     730  0 08:17 ?        00:00:01 /usr/bin/python3 /usr/share/system-config-printer/applet.py
```
🌞 Prouvez que le programme écoute derrière le port 8888
```
amimir@vbox:~$ sudo ss -lnpt | grep python
LISTEN 0      5            0.0.0.0:8888      0.0.0.0:*    users:(("python3",pid=3952,fd=3))
```

🌞 Faire en sote que le service se lance automatiquement au démarrage de la machine

```
amimir@vbox:~$ sudo systemctl enable meow_web.service
Created symlink /etc/systemd/system/multi-user.target.wants/meow_web.service → /etc/systemd/system/meow_web.service.
```