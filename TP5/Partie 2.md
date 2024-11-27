🌞 Avec une commande apt search, déterminez si le paquet ghidra est disponible
🌞 Ajouter l'URL des dépôts Kali à vos dépôts existants
🌞 Ajoutez la clé publique des gars de chez Kali
🌞 Mettez à jour la liste des dépôts que votre OS connaît actuellement
🌞 Avec une commande apt search, déterminez si le paquet ghidra est disponible
🌞 Installez le paquet ghidra
```
amimir@vbox:~/work$ ls
bom.json  Extensions  ghidraRun      GPL      licenses  support
docs      Ghidra      ghidraRun.bat  LICENSE  server
amimir@vbox:~/work$ file Ghidra
Ghidra: directory
amimir@vbox:~/work$ file ghidraRun
ghidraRun: Bourne-Again shell script, ASCII text executable
```

🌞 Récupérez le code de password_2.c sur la machine Linux et compilez-le

```
amimir@vbox:~/Desktop/crack$ ./password_5 caca
Access granted! Spawning shell...
$ exit
```
(Il y’avais une ligne a changer dans l’assembleur, la ligne JNZ que j’ai changer en JZ)

🌞 Récupérer le flag du programme kaddate_challenge

```
amimir@vbox:~/Desktop/crack$ ./kaddate_challenge
Can you be the first to send us a Message ?
Enter you message:

Sorry , you are not the first user (count=0). No flag for you.
Enter you message:
z
Congrats z, you are the first user (count=1).
Flag: b1-os{PetitB1deviendraGrandPetitB1}
```