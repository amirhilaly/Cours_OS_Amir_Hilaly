# Utilisateurs

## 1 - Liste des users

###  Afficher la ligne du fichier qui concerne votre utilisateur
- mettez uniquement cette ligne en évidence
- pas root, l'autre, que vous avez créé à l'installation
- faites déjà un cat du fichier pour voir à quoi ressemble son contenu
```
amimir@vbox:~$ cat /etc/passwd | grep amimir
amimir:x:1000:1000:Amir HILALY,,,:/home/amimir:/bin/bash
```

### Afficher la ligne du fichier qui concerne votre utilisateur ET celle de root en même temps
```
amimir@vbox:~$ cat /etc/passwd | grep -e amimir -e root
root:x:0:0:root:/root:/bin/bash
amimir:x:1000:1000:Amir HILALY,,,:/home/amimir:/bin/bash
```

### Afficher la liste des groupes d'utilisateurs de la machine
```
amimir@vbox:~$ cat /etc/group
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mail:x:8:
news:x:9:
uucp:x:10:
man:x:12:
proxy:x:13:
kmem:x:15:
dialout:x:20:
fax:x:21:
voice:x:22:
cdrom:x:24:amimir
floppy:x:25:amimir
tape:x:26:
sudo:x:27:amimir
audio:x:29:pulse,amimir
dip:x:30:amimir
www-data:x:33:
backup:x:34:
operator:x:37:
list:x:38:
irc:x:39:
src:x:40:
shadow:x:42:
utmp:x:43:
video:x:44:amimir
sasl:x:45:
plugdev:x:46:amimir
staff:x:50:
games:x:60:
users:x:100:amimir
nogroup:x:65534:
systemd-journal:x:999:
systemd-network:x:998:
crontab:x:101:
input:x:102:
sgx:x:103:
kvm:x:104:
render:x:105:
netdev:x:106:amimir
systemd-timesync:x:997:
messagebus:x:107:
_ssh:x:108:
ssl-cert:x:109:
avahi-autoipd:x:110:
bluetooth:x:111:amimir
avahi:x:112:
lpadmin:x:113:amimir
pulse:x:114:
pulse-access:x:115:
scanner:x:116:saned,amimir
saned:x:117:
lightdm:x:118:
polkitd:x:996:
rtkit:x:119:
colord:x:120:
amimir:x:1000:
marmotte:x:1001:
```

### Afficher la ligne du fichier qui concerne votre utilisateur ET celle de root en même temps

- afficher uniquement le nom d'utilisateur et le chemin vers leur répertoire personnel (celui de votre utilisateur est dans /home, celui de root c'est /root)
- on peut demander à cut d'afficher plusieurs colonnes avec -fx,y où x et y sont les deux numéros de colonnes qu'on veut afficher
- mettez uniquement ces deux lignes en évidence
```
amimir@vbox:~$ cat /etc/passwd | grep -e amimir -e root | cut -d ':' -f1,6
root:/root
amimir:/home/amimir
```


## 2 - Hash des passwords
Le hash des mots de passe des utilisateurs est stocké dans un fichier aussi : le fichier /etc/shadow.
### Afficher la ligne qui contient le hash du mot de passe de votre utilisateur
- mettez uniquement cette ligne en évidence

```
amimir@vbox:~$ sudo cat /etc/shadow | grep amimir
[sudo] password for amimir:
amimir:$y$j9T$mDGAuR0ey4RyesvJfpFDv0$C03WN.Q4rCooK/C2fNp9UU8xnPRuarEEv.Wm9ZCzgH6:20033:0:99999:7:::
```


## 3 - Sudo


## B. Practice
### Créer un groupe d'utilisateurs

- il devra s'appeler stronk_admins
```
sudo groupadd stronk_admins
```
### Créer un utilisateur

- il devra s'appeler imbob
- il devra avoir un mot de passe défini
- il devra appartenir aux groupes imbob et stronk_admins
```
sudo useradd imbob
sudo passwd imbob
sudo usermod -aG stronk_admins imbob
```
### Prouver que l'utilisateur imbob est créé

- en affichant une seule ligne du fichier /etc/passwd

```
amimir@vbox:~$ cat /etc/passwd | grep imbob
imbob:x:1002:1003::/home/imbob:/bin/sh
```
### Prouver que l'utilisateur imbob a un password défini

- en affichant une seule ligne du fichier /etc/shadow
```
amimir@vbox:~$ sudo cat /etc/shadow | grep imbob
imbob:$y$j9T$HX0H9lIfKNiO.tNbz3.YV1$qw9Y6tO6zIzHdK6ysQDgRlwzBYIb0dUQTzNsoZc3JqA:20039:0:99999:7:::
```

### Prouver que l'utilisateur imbob appartient au groupe stronk_admins

- la liste des groupes et de leurs membres c'est dans /etc/group
- affichez une seule ligne
```
amimir@vbox:~$ cat /etc/group | grep imbob
stronk_admins:x:1002:imbob
imbob:x:1003:
```
### Créer un deuxième utilisateur

- il devra s'appeler imnotbobsorry
- il devra avoir un mot de passe défini
- il devra appartenir au groupe imnotbobsorry
```
amimir@vbox:~$ sudo useradd imnotbobsorry
amimir@vbox:~$ sudo passwd imnotbobsorry
New password:
Retype new password:
passwd: password updated successfully
```

### Modifier la configuration de sudo pour que

- les membres du groupes stronk_admins ait le droit de taper des commandes apt en tant que root

- l'utilisateur imbob peut taper n'importe quelle commande en tant que root
```
amimir@vbox:~$ sudo visudo # pour modifier le dossier et ajouter %stronk_admins ALL=(ALL) NOPASSWD: ALL
amimir@vbox:~$ su imbob  

$sudo cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/run/ircd:/usr/sbin/nologin
_apt:x:42:65534::/nonexistent:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:998:998:systemd Network Management:/:/usr/sbin/nologin
systemd-timesync:x:997:997:systemd Time Synchronization:/:/usr/sbin/nologin
messagebus:x:100:107::/nonexistent:/usr/sbin/nologin
avahi-autoipd:x:101:110:Avahi autoip daemon,,,:/var/lib/avahi-autoipd:/usr/sbin/nologin
sshd:x:102:65534::/run/sshd:/usr/sbin/nologin
...
```

### Créer le dossier /home/goodguy (avec une commande)
```
amimir@vbox:/home$ sudo mkdir goodguy
```

### Changer le répertoire personnel de imbob

- avec une commande usermod, définissez ce dossier comme le répertoire personnel de imbob

- prouvez que le changement est effectif en affichant le contenu du fichier passwd

```
amimir@vbox:~$ sudo usermod -d /home/goodguy -m imbob
amimir@vbox:~$ cat /etc/passwd | grep imbob
imbob:x:1002:1003::/home/goodguy:/bin/sh
```

### Créer le dossier /home/badguy
### Changer le répertoire personnel de imnotbobsorry

avec une commande usermod, définissez ce dossier /home/badguy comme le répertoire personnel de imnotbobsorry

prouvez que le changement est effectif en affichant le contenu du fichier passwd

```
amimir@vbox:/home$ sudo mkdir badguy
amimir@vbox:/home$ sudo usermod -d /home/badguy -m imnotbobsorry
usermod: directory /home/badguy exists
amimir@vbox:/home$ cat /etc/passwd | grep imnotbobsorry
imnotbobsorry:x:1003:1004::/home/badguy:/bin/sh
```


🌞 Prouver que les permissions du dossier /home/gooduy sont incohérentes

ça n'appartient pas à l'utilisateur imbob

```
amimir@vbox:/home$ ls -l
total 16
drwx------ 19 amimir   amimir   4096 Nov 12 10:55 amimir
drwxr-xr-x  2 root     root     4096 Nov 12 18:17 badguy
drwxr-xr-x  2 root     root     4096 Nov 12 11:55 goodguy
drwxr-xr-x  2 marmotte marmotte 4096 Nov  7 11:30 papier_alu
```

🌞 Modifier les permissions de /home/goodguy

le dossier doit appartenir à imbob

pareil pour tout son contenu
avec une commande chown (il faudra mettre options et arguments)
```
amimir@vbox:/home$ sudo chown imbob:imbob goodguy
amimir@vbox:/home$ sudo chmod 700 goodguy
amimir@vbox:/home$ ls -l
total 16
drwx------ 19 amimir   amimir   4096 Nov 12 10:55 amimir
drwxr-xr-x  2 root     root     4096 Nov 12 18:17 badguy
drwx------  2 imbob    imbob    4096 Nov 12 11:55 goodguy
drwxr-xr-x  2 marmotte marmotte 4096 Nov  7 11:30 papier_alu
```
🌞 Modifier les permissions de /home/badguy

le dossier doit appartenir à imnotbobsorry

pareil pour tout son contenu
```
amimir@vbox:/home$ sudo chown imnotbobsorry:imnotbobsorry badguy
amimir@vbox:/home$ sudo chmod 700 badguy
amimir@vbox:/home$ ls -l
total 16
drwx------ 19 amimir        amimir        4096 Nov 12 10:55 amimir
drwx------  2 imnotbobsorry imnotbobsorry 4096 Nov 12 18:17 badguy
drwx------  2 imbob         imbob         4096 Nov 12 11:55 goodguy
drwxr-xr-x  2 marmotte      marmotte      4096 Nov  7 11:30 papier_alu
```

🌞 Connectez-vous sur l'utilisateur imbob

il faut utiliser la commande su - <USER> pour ouvrir une nouvelle session en tant qu'un utilisateur

ça doit sortir aucun message d'erreur particulier


si tu fais pwd tu devrais être dans le dossier /home/goodguy tout de suite après connexion (le répertoire personnel de imbob !)
si tu fais sudo echo meow ou n'importe quelle autre commande avec sudo, ça devrait fonctionner
```
amimir@vbox:~$ su imbob
Password:
$ pwd
/home/goodguy
```
🌞 Connectez-vous sur l'utilisateur imnotbobsorry

il faut utiliser la commande su - <USER> pour ouvrir une nouvelle session en tant qu'un utilisateur

ça doit sortir aucun message d'erreur particulier


si tu fais pwd tu devrais être dans le dossier /home/badguy tout de suite après
si tu fais sudo echo meow ou n'importe quelle autre commande avec sudo, ça ne devrait fonctionner PAS fonctionner

sauf les commandes sudo apt..., essaie un sudo apt update pour voir ?
```
$ su imnotbobsorry
Password:
$ pwd
/home/badguy
$ sudo ls
[sudo] password for imnotbobsorry:
imnotbobsorry is not in the sudoers file.
```