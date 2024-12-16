```
[amoumour@node1 opt]$ ls
id.sh  yt
[amoumour@node1 opt]$ cd yt
[amoumour@node1 yt]$ ./yt.sh https://www.youtube.com/watch?v=a4na2opArGY
Video https://www.youtube.com/watch?v=a4na2opArGY was downloaded.
File path: /opt/yt/downloads/DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts/DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts.mp4
[amoumour@node1 yt]$ cd downloads; ls
'DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts'
'[Official]_Celeste_B-Sides_-_07_-_Kuraine_-_Summit_(No_More_Running_Mix)'
[amoumour@node1 downloads]$ cd 'DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts'/; ls; cat description
'DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts.mp4'   description
DAN DA DAN OP "Otonoke" by Creepy Nuts. Watch DAN DA DAN on Crunchyroll! https://got.cr/cc-dandadanop

When high schooler Momo, from a family of spirit mediums, first meets her classmate Okarun, an occult geek, they argue—Momo believes in ghosts but denies aliens, and Okarun believes in aliens but denies ghosts. When it turns out both phenomena are real, Momo awakens a hidden power and Okarun gains the power of a curse. Together, they must challenge the paranormal forces threatening their world.

Crunchyroll brings you the latest clips, openings, full episodes, and more from your favorite anime!

FREE 7-DAY CRUNCHYROLL TRIAL 🌟 https://got.cr/cc-7daysop

#DANDADAN #Anime #Crunchyroll
[amoumour@node1 DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts]$ cat /var/log/yt
 Video https://www.youtube.com/watch?v=_YLk0kJ3Naw was downloaded. File path: /opt/yt/downloads/[Official]_Celeste_B-Sides_-_07_-_Kuraine_-_Summit_(No_More_Running_Mix)/[Official]_Celeste_B-Sides_-_07_-_Kuraine_-_Summit_(No_More_Running_Mix).mp4
 Video https://www.youtube.com/watch?v=a4na2opArGY was downloaded. File path: /opt/yt/downloads/DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts/DAN_DA_DAN_Opening_|_Otonoke_by_Creepy_Nuts.mp4
```






🌞 Toutes les commandes que vous utilisez
```
[amoumour@node1 opt]$ ls -l
total 4
-rwxr-xr-x. 1 root root 1642 Dec 16 16:14 id.sh
drwxr-xr-x. 3 yt   root   74 Dec 16 16:13 yt
[amoumour@node1 opt]$ cd yt; ls -l
total 12
drwxr-xr-x. 2 yt   amoumour    6 Dec 16 16:26 downloads
-rw-r--r--. 1 root root       88 Dec 16 15:18 test.txt
-rwxr-xr-x. 1 yt   root     1130 Dec 16 16:13 yt-next-gen.sh
-rwxr-xr-x. 1 root root      935 Dec 16 14:01 yt.sh
[amoumour@node1 yt]$ ls -l /var/log/yt/downloads.log
-rw-r--r--. 1 yt root 2045 Dec 16 16:24 /var/log/yt/downloads.log
```

🌞 Le script yt-next-gen.sh dans le dépôt git
🌞 Le fichier yt.service dans le dépôt git