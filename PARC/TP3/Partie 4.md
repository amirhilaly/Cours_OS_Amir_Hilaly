




🌞 Partitionner le disque dur

```
[amoumour@backup ~]$ sudo pvcreate /dev/sdb
[sudo] password for amoumour:
  Physical volume "/dev/sdb" successfully created.

[amoumour@backup ~]$ sudo vgcreate vg_data /dev/sdb
  Volume group "vg_data" successfully created
[amoumour@backup ~]$ sudo lvcreate -l 100%FREE vg_data -n lv_partition
  Logical volume "lv_partition" created.
```

🌞 Formater la partition créée

```
[amoumour@backup ~]$ sudo mkfs.ext4 /dev/vg_data/lv_partition
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 1309696 4k blocks and 327680 inodes
Filesystem UUID: 66ecb87f-d71d-43ac-b3cb-e10139955e08
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736
```

🌞 Monter la partition

```
[amoumour@backup ~]$ sudo vgcreate vg_data /dev/sdb
  Volume group "vg_data" successfully created
[amoumour@backup ~]$ sudo lvcreate -l 100%FREE vg_data -n lv_partition
  Logical volume "lv_partition" created.
[amoumour@backup ~]$ sudo mkdir -p /mnt/backup
[amoumour@backup ~]$ sudo mount /dev/vg_data/lv_partition /mnt/backup
[amoumour@backup ~]$ df -h
mount | grep backup
Filesystem                        Size  Used Avail Use% Mounted on
devtmpfs                          4.0M     0  4.0M   0% /dev
tmpfs                             888M     0  888M   0% /dev/shm
tmpfs                             355M  5.0M  350M   2% /run
/dev/mapper/rl_vbox-root          4.4G  1.3G  3.1G  29% /
/dev/sda1                         960M  230M  731M  24% /boot
tmpfs                             178M     0  178M   0% /run/user/1000
/dev/mapper/vg_data-lv_partition  4.9G   24K  4.6G   1% /mnt/backup
/dev/mapper/vg_data-lv_partition on /mnt/backup type ext4 (rw,relatime,seclabel)
```

🌞 Configurer un montage automatique de la partition

```
[amoumour@backup ~]$ sudo nano /etc/fstab
(je rajoute la ligne /dev/vg_data/lv_partition /mnt/backup ext4 defaults 0 0)
```


🌞 Installer et configurer un service NFS

```
[amoumour@music ~]$ sudo firewall-cmd --permanent --list-all | grep services
  services: cockpit dhcpv6-client mountd nfs rpc-bind ssh
```

🌞 Déterminer sur quel port écoute le service NFS

```
[amoumour@music ~]$ sudo ss -lnpt | grep rpc
LISTEN 0      4096         0.0.0.0:111        0.0.0.0:*    users:(("rpcbind",pid=2786,fd=4),("systemd",pid=1,fd=51))
LISTEN 0      4096         0.0.0.0:50635      0.0.0.0:*    users:(("rpc.statd",pid=2788,fd=9))
LISTEN 0      4096         0.0.0.0:20048      0.0.0.0:*    users:(("rpc.mountd",pid=2793,fd=5))
LISTEN 0      4096            [::]:111           [::]:*    users:(("rpcbind",pid=2786,fd=6),("systemd",pid=1,fd=53))
LISTEN 0      4096            [::]:34129         [::]:*    users:(("rpc.statd",pid=2788,fd=11))
LISTEN 0      4096            [::]:20048         [::]:*    users:(("rpc.mountd",pid=2793,fd=7))
```

🌞 Installer les outils NFS

```
(reverse-i-search)`dnf': sudo dnf install nfs-utils
```
(j'avais deja installer sur le client car ils disent de le faire dans la doc :p)

🌞 Essayer d'accéder au dossier partagé

```
[amoumour@music ~]$ sudo mount 10.3.1.13:/mnt/backup /mnt/music_backup
[amoumour@music music_backup]$ touch /mnt/music_backup/bomb
[amoumour@backup backup]$ ls
bomb  lost+found
```

🌞 Configurer un montage automatique

```
[amoumour@music opt]$ sudo nano /etc/fstab
```

🌞 Script backup.sh

```
[amoumour@music opt]$ ./backup.sh
La sauvegarde a été effectuée avec succès : /mnt/music_backup/music_250115_101653.tar.gz
```

🌞 Créer un nouveau service backup.service

```
[amoumour@music system]$ sudo touch backup.service
```

🌞 Indiquer au système qu'on a ajouté un nouveau service

```
[amoumour@music opt]$ sudo systemctl daemon-reload
```

🌞 Utiliser et tester le nouveau service

```
[amoumour@music system]$ sudo systemctl daemon-reload
[amoumour@music system]$ systemctl status backup
○ backup.service - <Votre description>
     Loaded: loaded (/etc/systemd/system/backup.service; disabled; preset: disabled)
     Active: inactive (dead)
[amoumour@music system]$ sudo systemctl status backup
○ backup.service - <Votre description>
     Loaded: loaded (/etc/systemd/system/backup.service; disabled; preset: disabled)
     Active: inactive (dead)
[amoumour@music system]$ systemctl start backup
Failed to start backup.service: Access denied
See system logs and 'systemctl status backup.service' for details.
[amoumour@music system]$ sudo systemctl start backup
```

🌞 Faire un test et prouvez que ça a fonctionné

```
[amoumour@music system]$ sudo systemctl start backup
[amoumour@backup backup]$ ls
bomb  lost+found  music_250115_101653.tar.gz  music_250115_102621.tar.gz  music_250115_102835.tar.gz  music_250115_103024.tar.gz
```

🌞 Configurer un lancement automatique du service à intervalles réguliers

```
Description=Backup musik!
[Timer]
OnCalendar=hourly
Persistent=true

[Install]
WantedBy=timers.target
```
