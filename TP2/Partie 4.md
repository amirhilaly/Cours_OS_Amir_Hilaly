# Poupée russe

## Téléchargement du fichier:
git clone https://gitlab.com/it4lik/b1-os.git  
Ensuite j'ai déplacer le fichier meow dans home avec  
mv meow ~/

## Pour l'extraction de meow:
```
amimir@vbox:~$ file meow  
meow: Zip archive data, at least v2.0 to extract, compression method=deflate  
amimir@vbox:~$ mv meow meow.zip  
amimir@vbox:~$ ls  
b1-os  Desktop  Documents  Downloads  meow.zip  Music  OS  Pictures  Public  Templates  Videos  
amimir@vbox:~$ unzip meow.zip   
Archive:  meow.zip  
  inflating: meow  
amimir@vbox:~$ ls  
b1-os  Desktop  Documents  Downloads  meow  meow.zip  Music  OS  Pictures  Public  Templates  Videos
amimir@vbox:~$ file meow
meow: XZ compressed data, checksum CRC64
amimir@vbox:~$ mv meow meow.xz
amimir@vbox:~$ unxz meow.xz
amimir@vbox:~$ ls
b1-os  Desktop  Documents  Downloads  meow  meow.zip  Music  OS  Pictures  Public  Templates  Videos
amimir@vbox:~$ file meow
meow: bzip2 compressed data, block size = 900k
amimir@vbox:~$ mv meow meow.bz2
amimir@vbox:~$ bunzip2 meow.bz2
famimir@vbox:~$ file meow
meow: RAR archive data, v5
amimir@vbox:~$ mv meow meow.rar
unrar-free -x meow.rar
file meow  
mv meow meow.gz  
gzip -d meow.gz
file meow
tar -xf meow dawa/
cd dawa
```

## Recherche dans le fichier dawa

Fichier contenant 15Mo:
```
amimir@vbox:~/test/dawa$ find . -type f -size 15M
./folder31/19/file39
```

Seul fichié ne contenant que des 7:
```
amimir@vbox:~/test/dawa$ find . -type f -exec grep -l '^[7]*$' {} \;
./folder31/19/file39

```

Seul fichier nommé cookie:

```
amimir@vbox:~/test/dawa$ find . -type f -name 'cookie'
./folder14/25/cookie
```

Seul fichier caché:
```
amimir@vbox:~/test/dawa$ find . -type f -name '.*'
./folder32/14/.hidden_file
```

Seul fichié qui date de 2014:
```
find . -type f -newermt '2014-01-01' ! -newermt '2015-01-01'
```

Seul fichier ayant 5 dossiers parents:
```
amimir@vbox:~/test/dawa$ find . -type f | awk -F'/' '{if (NF == 7) print $0}'
./folder37/45/23/43/54/file43
```
Un peu d'explication pour le dernier car ca me laisse un goût amer GTP:  
- find . pour utiliser find dans le dossier actual (ici dawa),  
- type f car on veut un fichier  
- awk avec l'option -F'/' pour découper avec des / puisque on travaille sur des dossiers, on va pouvoir compter le nombre d'éléments avec ce séparateur
- {if (NF == 7) print $0} pour dire que si y'a 7 éléments (les 5 dossiers + le dossier dawa et le fichier en question)

