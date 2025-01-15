🌞 Exécution du script autoconfig.sh développé à la partie I

[amoumour@music ~]$ sudo ./autoconfig.sh
Pti message de succès! Le SSH tourne déjà sur un autre port.
wheel:x:10:amoumour,root

🌞 Déposez quelques fichiers son là dedans

```
[amoumour@music srv]$ scp -P 1050 "C:\\Users\\amoum\\OneDrive\\Bureau\\bombeee\\Pharrell Williams - Double Life (From _Despicable Me 4_ - Official Audio).mp3" amoumour@10.3.1.11:/srv/music/
amoumour@10.3.1.11's password:
ssh: Could not resolve hostname c: Name or service not known
Connection closed
```

🌞 Ajoutez les dépôts nécessaires pour installer Jellyfin

sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm -y
[amoumour@music srv]$ sudo dnf config-manager --set-enabled crb


🌞 Installer le paquet jellyfin
```
[amoumour@music ~]$ sudo dnf install jellyfin -y
[sudo] password for amoumour:
Complete!
```

🌞 Lancer le service jellyfin

```
[amoumour@music ~]$ sudo systemctl start jellyfin
```

🌞 Afficher la liste des ports TCP en écoute

```
[amoumour@music ~]$ sudo ss -lntp | grep jellyfin
LISTEN 0      512          0.0.0.0:8096      0.0.0.0:*    users:(("jellyfin",pid=12012,fd=310))
```

🌞 Ouvrir le port derrière lequel Jellyfin écoute

```
[amoumour@music ~]$ sudo firewall-cmd --permanent --add-port=8096/tcp
```

🌞 Visitez l'interface Web !

```
[amoumour@music ~]$ curl -I "http://10.3.1.11:8096/web/index.html"
HTTP/1.1 200 OK
Content-Length: 7442
Content-Type: text/html
Date: Tue, 14 Jan 2025 19:03:39 GMT
Server: Kestrel
Accept-Ranges: bytes
ETag: "1da23514f439592"
Last-Modified: Thu, 30 Nov 2023 05:51:49 GMT
X-Response-Time-ms: 0
```

