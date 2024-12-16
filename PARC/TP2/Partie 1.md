🌞 Afficher la quantité d'espace disque disponible

```
[amoumour@node1 ~]$ df -mh | grep 'root' | tr -s ' ' | cut -d' ' -f4
3.1G
```


🌞 Afficher combien de fichiers il est possible de créer

```
[amoumour@node1 ~]$ df -i | grep root | cut -d' ' -f2
2304000
```


🌞 Afficher l'heure et la date

```
[amoumour@node1 ~]$ date +"%m/%d/%y %H/%M/%S"
12/09/24 16/12/17
```

🌞 Afficher la version de l'OS précise

```
[amoumour@node1 ~]$ source /etc/os-release; echo $NAME $VERSION_ID
Rocky Linux 9.5
```

🌞 Afficher la version du kernel en cours d'utilisation précise

```
[amoumour@node1 ~]$ uname -r
5.14.0-503.14.1.el9_5.x86_64
```

🌞 Afficher le chemin vers la commande python3

```
[amoumour@node1 ~]$ which python3
/usr/bin/python3
```


🌞 Afficher l'utilisateur actuellement connecté

```
[amoumour@node1 ~]$ echo $USER
amoumour
```


🌞 Afficher le shell par défaut de votre utilisateur actuellement connecté

```
[amoumour@node1 ~]$ cat /etc/passwd | grep bash | head -n1 | cut -d':' -f7
/bin/bash
```


🌞 Afficher le nombre de paquets installés

```
[amoumour@node1 ~]$ rpm -qa | wc -l
359
```

🌞 Afficher le nombre de ports en écoute

```
[amoumour@node1 ~]$ sudo ss -lntpu4H
udp         UNCONN         0              0                      127.0.0.1:323                  0.0.0.0:*          users:(("chronyd",pid=668,fd=5))
tcp         LISTEN         0              128                      0.0.0.0:22                   0.0.0.0:*          users:(("sshd",pid=704,fd=3))
```