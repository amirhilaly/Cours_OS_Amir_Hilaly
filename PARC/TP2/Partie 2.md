🌞 Ecrire un script qui produit exactement l'affichage demandé
🌞 Le script id.sh affiche l'état du firewall
🌞 Le script id.sh affiche l'URL vers une photo de chat random

```
voir le script bash
```

🌞 Stocker le fichier id.sh dans /opt

```
[amoumour@node1 opt]$ pwd
/opt
[amoumour@node1 opt]$ ls
id.sh
```

🌞 Prouvez que tout le monde peut exécuter le script

```
[amoumour@node1 opt]$ ls -al
total 4
drwxr-xr-x.  2 root root   19 Dec  9 17:35 .
dr-xr-xr-x. 18 root root  235 Nov 29 16:03 ..
-rwxr-xr-x.  1 root root 1444 Dec  9 17:35 id.sh
```

🌞 Ajouter l'exécution au .bashrc de votre utilisateur

```
PS C:\Users\amoum> ssh amoumour@10.2.1.1
amoumour@10.2.1.1's password:
Last login: Mon Dec  9 17:40:49 2024 from 10.2.1.3
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    89  100    89    0     0     38      0  0:00:02  0:00:02 --:--:--    38
Salu a toa amoumour.
Nouvelle connexion 12/09/24 17/43/39.
Connecté avec le shell /bin/bash.
OS : Rocky Linux 9.5 - Kernel : 5.14.0-503.14.1.el9_5.x86_64
Ressources :
  - 1.2Gi RAM dispo
  - 2.9G espace disque dispo
  - 2304000 fichiers restants
Actuellement :
  - 360 paquets installés
  - 3 port(s) ouvert(s)
Python est bien installé sur la machine au chemin : /usr/bin/python3

Firewall est actif
Tiens ton image de chat: https://cdn2.thecatapi.com/images/aq5.gif
```

⭐ BONUS : propose un script id.sh un peu plus...

```

```