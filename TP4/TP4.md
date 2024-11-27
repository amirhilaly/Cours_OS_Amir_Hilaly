

1/ Lister les périphériques de stockage branchés à la machine
```
amimir@vbox:~$:~$ lsblk
NAME             MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                8:0    0   20G  0 disk
└─sda1             8:1    0   20G  0 part
  ├─bababoy-root 254:0    0  9.3G  0 lvm  /
  ├─bababoy-Swap 254:1    0  1.9G  0 lvm  [SWAP]
  ├─bababoy-home 254:2    0  1.9G  0 lvm  /home
  ├─bababoy-var  254:3    0  2.8G  0 lvm  /var
  └─bababoy-FREE 254:4    0  2.8G  0 lvm
sr0               11:0    1 1024M  0 rom
sr1               11:1    1 1024M  0 rom
```

2/ Lister les partitions en cours d'utilisation

```
amimir@vbox:~$:~$ df -h
Filesystem                Size  Used Avail Use% Mounted on
udev                      951M     0  951M   0% /dev
tmpfs                     197M 1020K  196M   1% /run
/dev/mapper/bababoy-root  9.1G  4.0G  4.7G  46% /
tmpfs                     984M     0  984M   0% /dev/shm
tmpfs                     5.0M  8.0K  5.0M   1% /run/lock
/dev/mapper/bababoy-home  1.8G  1.7M  1.7G   1% /home
/dev/mapper/bababoy-var   2.7G  316M  2.3G  13% /var
tmpfs                     197M   52K  197M   1% /run/user/1000
```


1/ Lister la quantité d'inodes disponibles sur chaque partition

```
amimir@vbox:~$ df -i
Filesystem               Inodes  IUsed  IFree IUse% Mounted on
udev                     243442    446 242996    1% /dev
tmpfs                    251812    738 251074    1% /run
/dev/mapper/bababoy-root 610800 117545 493255   20% /
tmpfs                    251812      1 251811    1% /dev/shm
tmpfs                    251812      5 251807    1% /run/lock
/dev/mapper/bababoy-home 121920     86 121834    1% /home
/dev/mapper/bababoy-var  183264   6396 176868    4% /var
tmpfs                     50362     69  50293    1% /run/user/1000
```

2/ Déterminer la taille (avec du) et l'inode (avec ls) de chacun des fichiers suivants

```
amimir@vbox:~$ du -ls /boot/
138200  /boot/
amimir@vbox:~$ which bash
/usr/bin/bash
amimir@vbox:~$ du -ls /usr/bin/bash
1236    /usr/bin/bash
amimir@vbox:~$ du -ls /etc/passwd
4       /etc/passwd
```




1/ Repérer le nom des nouveaux disques

```
amimir@vbox:~$ lsblk
NAME             MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                8:0    0   20G  0 disk
└─sda1             8:1    0   20G  0 part
  ├─bababoy-root 254:0    0  9.3G  0 lvm  /
  ├─bababoy-Swap 254:1    0  1.9G  0 lvm  [SWAP]
  ├─bababoy-home 254:2    0  1.9G  0 lvm  /home
  ├─bababoy-var  254:3    0  2.8G  0 lvm  /var
  └─bababoy-FREE 254:4    0  2.8G  0 lvm
sdb                8:16   0   10G  0 disk
sdc                8:32   0   10G  0 disk
```

2/ Ajouter ces deux disques comme des PV LVM

```
amimir@vbox:~$ sudo pvcreate /dev/sdb
[sudo] password for amimir:
  Physical volume "/dev/sdb" successfully created.
amimir@vbox:~$ sudo pvcreate /dev/sdc
  Physical volume "/dev/sdc" successfully created.
3/ Créer un VG nommé cat

amimir@vbox:~$ sudo vgcreate cat /dev/sdb /dev/sdc
  Volume group "cat" successfully created
Vérification :

amimir@vbox:~$ sudo vgs
  VG      #PV #LV #SN Attr   VSize   VFree
  bababoy   1   5   0 wz--n- <20.00g <1.38g
  cat       2   0   0 wz--n-  19.99g 19.99g
amimir@vbox:~$ sudo vgdisplay
  --- Volume group ---
  VG Name               cat
  System ID
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               19.99 GiB
  PE Size               4.00 MiB
  Total PE              5118
  Alloc PE / Size       0 / 0
  Free  PE / Size       5118 / 19.99 GiB
  VG UUID               6EF0G9-GZOr-l9h1-6VJT-3yfz-7ccT-JQznht

  --- Volume group ---
  VG Name               bababoy
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  6
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                5
  Open LV               4
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <20.00 GiB
  PE Size               4.00 MiB
  Total PE              5119
  Alloc PE / Size       4766 / <18.62 GiB
  Free  PE / Size       353 / <1.38 GiB
  VG UUID               rkY1y6-qw1A-eUgK-QKIz-v4JX-LVDt-210K1L
```

4/ Créer un LV nommé meoooow

```
amimir@vbox:~$ sudo lvcreate -L 3G cat -n meoooow
  Logical volume "meoooow" created.
```


5/ Formater la partition (le LV) en autre chose que ext4

```
amimir@vbox:~$ sudo apt install xfsprogs
amimir@vbox:~$ sudo mkfs -t xfs /dev/cat/meoooow
meta-data=/dev/cat/meoooow       isize=512    agcount=4, agsize=196608 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=786432, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
```

6/ Créer le point de montage /mnt/meow

```
amimir@vbox:~$ sudo mkdir /mnt/meow
```

7/ Monter la partition meoooow sur le point de montage que vous avez créé & Vérifier avec la commande adaptée que la partition est utilisable et qu'elle fait 3G
```
amimir@vbox:~$ sudo mount /dev/cat/meoooow /mnt/meow/
amimir@vbox:~$ mount | grep meoooow
/dev/mapper/cat-meoooow on /mnt/meow type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)  
amimir@vbox:~$ df -h
Filesystem                Size  Used Avail Use% Mounted on
udev                      951M     0  951M   0% /dev
tmpfs                     197M  1.1M  196M   1% /run
/dev/mapper/bababoy-root  9.1G  4.0G  4.7G  46% /
tmpfs                     984M     0  984M   0% /dev/shm
tmpfs                     5.0M  8.0K  5.0M   1% /run/lock
/dev/mapper/bababoy-home  1.8G  1.7M  1.7G   1% /home
/dev/mapper/bababoy-var   2.7G  340M  2.2G  14% /var
tmpfs                     197M   52K  197M   1% /run/user/1000
/dev/mapper/cat-meoooow   3.0G   54M  2.9G   2% /mnt/meow
```
1. Grow !

1/ Agrandir /home de +2G et le prouver

```
amimir@vbox:~$ sudo lvextend -L +2G /dev/bababoy/home
  Size of logical volume bababoy/home changed from <1.86 GiB (476 extents) to <3.86 GiB (988 extents).
  Logical volume bababoy/home successfully resized.
amimir@vbox:~$ sudo resize2fs /dev/bababoy/home
resize2fs 1.47.0 (5-Feb-2023)
Filesystem at /dev/bababoy/home is mounted on /home; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 1
The filesystem on /dev/bababoy/home is now 1011712 (4k) blocks long.

amimir@vbox:~$ df -h /home
Filesystem                Size  Used Avail Use% Mounted on
/dev/mapper/bababoy-home  3.8G  1.7M  3.6G   1% /home
2/ Agrandir la partition meoooow pour qu'elle occupe tout l'espace libre de son VG

amimir@vbox:~$ sudo lvextend -l +100%FREE /dev/cat/meoooow
  Size of logical volume cat/meoooow changed from 3.00 GiB (768 extents) to 19.99 GiB (5118 extents).
  Logical volume cat/meoooow successfully resized.
amimir@vbox:~$ sudo xfs_growfs /dev/cat/meoooow
meta-data=/dev/mapper/cat-meoooow isize=512    agcount=4, agsize=196608 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=786432, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 786432 to 5240832  

amimir@vbox:~$ df -h /dev/cat/meoooow
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/cat-meoooow   20G  176M   20G   1% /mnt/meow
```


1/ Modifier le fichier /etc/fstab pour que la partition soit montée /mnt/meow automatiquement
```
amimir@vbox:~$/dev/cat$ sudo nano /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# systemd generates mount units based on this file, see systemd.mount(5).
# Please run 'systemctl daemon-reload' after making changes here.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/mapper/bababoy-root /               ext4    errors=remount-ro 0       1
/dev/mapper/bababoy-home /home           ext4    defaults        0       2
/dev/mapper/bababoy-var /var            ext4    defaults        0       2
/dev/mapper/bababoy-Swap none            swap    sw              0       0
/dev/cat/meoooow /mnt/meow              xfs     defaults       0 0
/dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0
```

Vérification :

```
amimir@vbox:~$/dev/cat$ sudo umount /mnt/meow
amimir@vbox:~$/dev/cat$ sudo mount -av
/                        : ignored
/home                    : already mounted
/var                     : already mounted
none                     : ignored
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
/mnt/meow                : successfully mounted
/media/cdrom0            : ignored
/media/cdrom1            : ignored
```