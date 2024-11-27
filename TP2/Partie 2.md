### Trouver le chemin vers le répertoire personnel de votre utilisateur

```
cat /etc/passwd  
/home/amimir:/bin/bash
```

### Vérifier les permissions du répertoire personnel de votre utilisateurs

```
amimir@vbox:~$ ls -l /home/amimir  
total 36  
drwxr-xr-x 4 amimir amimir 4096 Nov  7 10:46 Desktop  
drwxr-xr-x 2 amimir amimir 4096 Nov  6 11:56 Documents  
drwxr-xr-x 2 amimir amimir 4096 Nov  6 11:56 Downloads  
drwxr-xr-x 2 amimir amimir 4096 Nov  6 11:56 Music  
drwxr-xr-x 2 root   root   4096 Nov  6 12:16 OS  
drwxr-xr-x 2 amimir amimir 4096 Nov  6 11:56 Pictures  
drwxr-xr-x 2 amimir amimir 4096 Nov  6 11:56 Public  
drwxr-xr-x 2 amimir amimir 4096 Nov  6 11:56 Templates  
drwxr-xr-x 2 amimir amimir 4096 Nov  6 11:56 Videos  
```

 
### Trouver le chemin du fichier de configuration du serveur SSH
```
root@vbox:/# find . -name sshd_config
./etc/ssh/sshd_config
```
### Trouver le chemin du fichier de logs SSH
à faire



## Users
### Créer un nouvel utilisateur  
sudo useradd -m -d /home/papier_alu marmotte  
passwd marmotte  
(ensuite je tappe chocolat)  

### Prouver que cet utilisateur à été créer
cat /etc/passwd | grep marmotte
marmotte:x:1001:1001::/home/papier_alu:/bin/sh

### Déterminer le hash du password de l'utilisateur marmotte
sudo cat /etc/shadow | grep marmotte  
```
marmotte:$y$j9T$nTjsJknTmIKydf0RQth1z0$IZrMWlp.dgao23VYqa5BvVf2WXL2Z9k1NFrThfdyNC4:20034:0:99999:7:::
```


### Tapez une commande pour vous déconnecter : fermer votre session utilisateur

```
exit
```

### Assurez-vous que vous pouvez vous connecter en tant que l'utilisateur marmotte
```
su marmotte  
cd /home/papier_alu
```