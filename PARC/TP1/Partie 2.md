
🌞 Installer le serveur NGINX

```
[amoumour@web ~]$ dnf search nginx
Rocky Linux 9 - BaseOS                                                  152 kB/s | 2.3 MB     00:15
Rocky Linux 9 - AppStream                                               177 kB/s | 8.3 MB     00:48
Rocky Linux 9 - Extras                                                  2.4 kB/s |  16 kB     00:06
Last metadata expiration check: 0:00:01 ago on Mon 02 Dec 2024 02:23:31 PM CET.
===================================== Name Exactly Matched: nginx ======================================nginx.x86_64 : A high performance web server and reverse proxy server
==================================== Name & Summary Matched: nginx =====================================
nginx-all-modules.noarch : A meta package that installs all available Nginx modules
nginx-core.x86_64 : nginx minimal core
nginx-filesystem.noarch : The basic directory layout for the Nginx server
nginx-mod-http-image-filter.x86_64 : Nginx HTTP image filter module
nginx-mod-http-perl.x86_64 : Nginx HTTP perl module
nginx-mod-http-xslt-filter.x86_64 : Nginx XSLT module
nginx-mod-mail.x86_64 : Nginx mail modules
nginx-mod-stream.x86_64 : Nginx stream modules
pcp-pmda-nginx.x86_64 : Performance Co-Pilot (PCP) metrics for the Nginx Webserver
[amoumour@web ~]$ dnf install nginx
Error: This command has to be run with superuser privileges (under the root user on most systems).
[amoumour@web ~]$ sudo dnf install nginx
[sudo] password for amoumour:
Rocky Linux 9 - BaseOS                                                  848  B/s | 4.1 kB     00:04
Rocky Linux 9 - AppStream                                               977  B/s | 4.5 kB     00:04
Rocky Linux 9 - Extras                                                  698  B/s | 2.9 kB     00:04
Dependencies resolved.
========================================================================================================
 Package                     Architecture     Version                         Repository           Size
========================================================================================================
Installing:
 nginx                       x86_64           2:1.20.1-20.el9.0.1             appstream            36 k
Installing dependencies:
 nginx-core                  x86_64           2:1.20.1-20.el9.0.1             appstream           566 k
 nginx-filesystem            noarch           2:1.20.1-20.el9.0.1             appstream           8.4 k
 rocky-logos-httpd           noarch           90.15-2.el9                     appstream            24 k

Transaction Summary
========================================================================================================
Install  4 Packages

Total download size: 634 k
Installed size: 1.8 M
Is this ok [y/N]: y
Downloading Packages:
(1/4): nginx-filesystem-1.20.1-20.el9.0.1.noarch.rpm                    1.6 kB/s | 8.4 kB     00:05
(2/4): rocky-logos-httpd-90.15-2.el9.noarch.rpm                         4.6 kB/s |  24 kB     00:05
(3/4): nginx-1.20.1-20.el9.0.1.x86_64.rpm                               6.8 kB/s |  36 kB     00:05
(4/4): nginx-core-1.20.1-20.el9.0.1.x86_64.rpm                          387 kB/s | 566 kB     00:01
--------------------------------------------------------------------------------------------------------
Total                                                                    68 kB/s | 634 kB     00:09
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                1/1
  Running scriptlet: nginx-filesystem-2:1.20.1-20.el9.0.1.noarch                                    1/4
  Installing       : nginx-filesystem-2:1.20.1-20.el9.0.1.noarch                                    1/4
  Installing       : nginx-core-2:1.20.1-20.el9.0.1.x86_64                                          2/4
  Installing       : rocky-logos-httpd-90.15-2.el9.noarch                                           3/4
  Installing       : nginx-2:1.20.1-20.el9.0.1.x86_64                                               4/4
  Running scriptlet: nginx-2:1.20.1-20.el9.0.1.x86_64                                               4/4
  Verifying        : rocky-logos-httpd-90.15-2.el9.noarch                                           1/4
  Verifying        : nginx-filesystem-2:1.20.1-20.el9.0.1.noarch                                    2/4
  Verifying        : nginx-2:1.20.1-20.el9.0.1.x86_64                                               3/4
  Verifying        : nginx-core-2:1.20.1-20.el9.0.1.x86_64                                          4/4

Installed:
  nginx-2:1.20.1-20.el9.0.1.x86_64                      nginx-core-2:1.20.1-20.el9.0.1.x86_64
  nginx-filesystem-2:1.20.1-20.el9.0.1.noarch           rocky-logos-httpd-90.15-2.el9.noarch

Complete!
```

🌞 Démarrer le service NGINX

```
[amoumour@web ~]$ sudo systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[amoumour@web ~]$ sudo systemctl start nginx
```

🌞 Déterminer sur quel port tourne NGINX

```
[amoumour@web ~]$ sudo ss -lntp | grep nginx
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=1544,fd=6),("nginx",pid=1543,fd=6))
LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=1544,fd=7),("nginx",pid=1543,fd=7))
```

🌞 Déterminer les processus liés au service NGINX

```
[amoumour@web ~]$ ps -ef | grep "nginx"
root        1543       1  0 14:29 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       1544    1543  0 14:29 ?        00:00:00 nginx: worker process
```

🌞 Déterminer le nom de l'utilisateur qui lance NGINX

```
[amoumour@web ~]$ cat /etc/passwd | grep nginx
nginx:x:996:993:Nginx web server:/var/lib/nginx:/sbin/nologin
```

🌞 Test !

```
[amoumour@web ~]$ curl http://10.1.1.1/
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

      html {
        height: 100%;
        width: 100%;
      }
        body {
```
(le contenu est bad long donc j'ai mis que le debut mais en gros ca marche!)


🌞 Déterminer le path du fichier de configuration de NGINX

```
[amoumour@web nginx]$ ls -al /etc/nginx/nginx.conf
-rw-r--r--. 1 root root 2334 Nov  8 17:43 /etc/nginx/nginx.conf
```

🌞 Trouver dans le fichier de conf
- les lignes qui permettent de faire tourner un site web d'accueil (la page moche que vous avez vu avec votre navigateur)
```
[amoumour@web nginx]$ cat nginx.conf | grep server -A 5
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }
--
# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2;
#        listen       [::]:443 ssl http2;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers PROFILE=SYSTEM;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
```

- une ligne qui commence par include

```
[amoumour@web nginx]$ cat nginx.conf | grep include
include /usr/share/nginx/modules/*.conf;
    include             /etc/nginx/mime.types;
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/default.d/*.conf;
#        include /etc/nginx/default.d/*.conf;
```
(la ligne ```include /etc/nginx/conf.d/*.conf;``` est la plus importante ici)

- la ligne qui indique à NGINX qu'il doit s'exécuter en tant qu'un utilisateur spécifique

```
[amoumour@web nginx]$ cat nginx.conf | grep -in user
5:user nginx;
18:    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
20:                      '"$http_user_agent" "$http_x_forwarded_for"';
```


🌞 Créer un site web

```
[amoumour@web nginx]$ cd /var/
[amoumour@web var]$ ls
adm    crash  empty  games     lib    lock  mail  opt       run    tmp
cache  db     ftp    kerberos  local  log   nis   preserve  spool  yp
[amoumour@web var]$ mkdir www
mkdir: cannot create directory ‘www’: Permission denied
[amoumour@web var]$ sudo mkdir www
[sudo] password for amoumour:
[amoumour@web var]$ cd www
[amoumour@web www]$ mkdir tp1_parc
mkdir: cannot create directory ‘tp1_parc’: Permission denied
[amoumour@web www]$ sudo mkdir tp1_parc
[amoumour@web www]$ cd tp1_parc/
[amoumour@web tp1_parc]$ touch index.html
touch: cannot touch 'index.html': Permission denied
[amoumour@web tp1_parc]$ sudo touch index.html
```




🌞 Gérer les permissions

```
[amoumour@web www]$ sudo chown nginx:nginx /var/www/*
[sudo] password for amoumour:
[amoumour@web www]$ ls èl
ls: cannot access 'èl': No such file or directory
[amoumour@web www]$ ls -l
total 0
drwxr-xr-x. 2 nginx nginx 24 Dec  2 14:59 tp1_parc
```

🌞 Adapter la conf NGINX

```
[amoumour@web nginx]$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[amoumour@web nginx]$ sudo systemctl restart nginx


[amoumour@web nginx]$ cat site_web.conf
server {
  # le port choisi devra être obtenu avec un 'echo $RANDOM' là encore
  listen 16369;

  root /var/www/tp1_parc;
}


[amoumour@web nginx]$ sudo systemctl restart nginx
```

🌞 Visitez votre super site web

```
[amoumour@web tp1_parc]$ curl http://10.1.1.1:16369/
<h1>MEOW mon premier serveur web</h1>
```
