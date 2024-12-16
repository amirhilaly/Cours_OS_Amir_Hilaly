🌞 S'assurer que le service sshd est démarré
```
[amoumour@bomb ~]$ systemctl status
● bomb
    State: running
    Units: 283 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Fri 2024-11-29 17:08:49 CET; 7min ago
  systemd: 252-46.el9_5.2.0.1
   CGroup: /
           ├─init.scope
           │ └─1 /usr/lib/systemd/systemd --switched-root --system --deserialize 31
           ├─system.slice
           │ ├─NetworkManager.service
           │ │ └─673 /usr/sbin/NetworkManager --no-daemon
           │ ├─auditd.service
           │ │ └─637 /sbin/auditd
           │ ├─chronyd.service
           │ │ └─670 /usr/sbin/chronyd -F 2
           │ ├─crond.service
           │ │ └─710 /usr/sbin/crond -n
           │ ├─dbus-broker.service
           │ │ ├─663 /usr/bin/dbus-broker-launch --scope system --audit
           │ │ └─664 dbus-broker --log 4 --controller 9 --machine-id d9486b29058a446c>
           │ ├─firewalld.service
           │ │ └─667 /usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid
           │ ├─rsyslog.service
           │ │ └─760 /usr/sbin/rsyslogd -n
           │ ├─sshd.service
           │ │ └─704 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"
           │ ├─systemd-journald.service
           │ │ └─553 /usr/lib/systemd/systemd-journald
           │ ├─systemd-logind.service
           │ │ └─668 /usr/lib/systemd/systemd-logind
           │ └─systemd-udevd.service
           │   └─udev
           │     └─566 /usr/lib/systemd/systemd-udevd
           └─user.slice
             └─user-1000.slice
               ├─session-1.scope
               │ ├─ 711 "login -- amoumour"
               │ └─1228 -bash
               ├─session-3.scope
               │ ├─1253 "sshd: amoumour [priv]"
               │ ├─1257 "sshd: amoumour@pts/0"
               │ ├─1258 -bash
               │ ├─1284 systemctl status
               │ └─1285 less
               └─user@1000.service
                 └─init.scope
                   ├─1219 /usr/lib/systemd/systemd --user
                   └─1221 "(sd-pam)"
```

🌞 Analyser les processus liés au service SSH
```
[amoumour@bomb ~]$ ps -l -ef | grep sshd | head -3
4 S root         704       1  0  80   0 -  4199 -      17:08 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
4 S root        1253     704  0  80   0 -  5040 -      17:09 ?        00:00:00 sshd: amoumour [priv]
5 S amoumour    1257    1253  0  80   0 -  5088 -      17:09 ?        00:00:00 sshd: amoumour@pts/0
```


🌞 Déterminer le port sur lequel écoute le service SSH
```
[amoumour@bomb ~]$ sudo ss -alnpt
[sudo] password for amoumour:
State        Recv-Q       Send-Q              Local Address:Port               Peer Address:Port       Process
LISTEN       0            128                       0.0.0.0:22                      0.0.0.0:*           users:(("sshd",pid=704,fd=3))
LISTEN       0            128                          [::]:22                         [::]:*           users:(("sshd",pid=704,fd=4))
```
(j'ai pas mis de grep puisque sans y'avait que ca d'afficher)


🌞 Consulter les logs du service SSH
```
[amoumour@bomb ~]$ sudo journalctl -xe -u sshd
[sudo] password for amoumour:
~
~
~
Nov 29 17:08:58 bomb systemd[1]: Starting OpenSSH server daemon...
░░ Subject: A start job for unit sshd.service has begun execution
░░ Defined-By: systemd
░░ Support: https://wiki.rockylinux.org/rocky/support
░░
░░ A start job for unit sshd.service has begun execution.
░░
░░ The job identifier is 230.
Nov 29 17:08:58 bomb sshd[704]: Server listening on 0.0.0.0 port 22.
Nov 29 17:08:58 bomb sshd[704]: Server listening on :: port 22.
Nov 29 17:08:58 bomb systemd[1]: Started OpenSSH server daemon.
░░ Subject: A start job for unit sshd.service has finished successfully
░░ Defined-By: systemd
░░ Support: https://wiki.rockylinux.org/rocky/support
░░
░░ A start job for unit sshd.service has finished successfully.
░░
░░ The job identifier is 230.
Nov 29 17:09:47 bomb sshd[1253]: Accepted password for amoumour from 10.1.1.2 port 44657 ssh2
Nov 29 17:09:47 bomb sshd[1253]: pam_unix(sshd:session): session opened for user amoumour(uid=1000) by amoumour(uid=0)
```

🌞 Identifier le fichier de configuration du serveur SSH
```
[amoumour@bomb /]$ cd /etc/ssh
[amoumour@bomb ssh]$ ls
moduli      ssh_config.d  sshd_config.d       ssh_host_ecdsa_key.pub  ssh_host_ed25519_key.pub  ssh_host_rsa_key.pub
ssh_config  sshd_config   ssh_host_ecdsa_key  ssh_host_ed25519_key    ssh_host_rsa_key
[amoumour@bomb ssh]$ c'est sshd_config ducoup lol
```


🌞 Modifier le fichier de conf
```
[amoumour@bomb ssh]$ echo $RANDOM
18603
[amoumour@bomb ssh]$ sudo cat sshd_config | grep Port | head -1
Port 18603
[amoumour@bomb ~]$ sudo firewall-cmd --list-all | grep ports | head -1
  ports: 18603/tcp
```

🌞 Redémarrer le service
```
[amoumour@bomb ~]$ sudo systemctl restart sshd
```

🌞 Effectuer une connexion SSH sur le nouveau port
```
PS C:\Users\amoum> ssh amoumour@10.1.1.1 -p 18603
amoumour@10.1.1.1's password:
Last login: Fri Nov 29 17:42:56 2024 from 10.1.1.2
[amoumour@bomb ~]$
```
