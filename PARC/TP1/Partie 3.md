🌞 Installer Netdata

```
[amoumour@web tp1_parc]$ curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --no-updates --stable-channel --disable-telemetry

```
🌞 Démarrer le service netdata

```
[amoumour@web tp1_parc]$ sudo systemctl start netdata
```

🌞 Déterminer sur quel port tourne Netdata

```
[amoumour@vbox ~]$ sudo ss -lnpt | grep netdata
LISTEN 0      4096       127.0.0.1:8125       0.0.0.0:*    users:(("netdata",pid=2774,fd=46))
LISTEN 0      4096         0.0.0.0:19999      0.0.0.0:*    users:(("netdata",pid=2774,fd=6))
LISTEN 0      4096           [::1]:8125          [::]:*    users:(("netdata",pid=2774,fd=45))
LISTEN 0      4096            [::]:19999         [::]:*    users:(("netdata",pid=2774,fd=7))
[amoumour@web tp1_parc]$ sudo firewall-cmd --permanent --add-port=19999/tcp
success
[amoumour@web tp1_parc]$ sudo firewall-cmd --reload
success
```

🌞 Visiter l'interface Web

```
[amoumour@vbox ~]$ curl http://10.1.1.3:19999/ | head -7
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html><html lang="en" dir="ltr"><head><meta charset="utf-8"/><title>Netdata</title><script>const CONFIG = {
      cache: {
        agentInfo: false,
        cloudToken: true,
        agentToken: true,
      }
    }
 93  106k   93   99k    0     0  6642k      0 --:--:-- --:--:-- --:--:-- 6642k
```
(encore une fois je cut short pcq c'est une big page c:)


🌞 Ajouter un check

```
[amoumour@vbox ~]$ cd /etc/netdata 2>/dev/null || cd /opt/netdata/etc/netdata
[amoumour@vbox netdata]$ sudo ./edit-config go.d/portcheck.conf
Copying '/etc/netdata/../../usr/lib/netdata/conf.d//go.d/portcheck.conf' to '/etc/netdata//go.d/portcheck.conf' ...
Editing '/etc/netdata/go.d/portcheck.conf' ...


Dans ma conf y'a ca:

jobs:
  - name: WEB_web.tp1.b1
    host: 10.1.1.1
    ports:
      - 16369
      

[amoumour@vbox netdata]$ sudo systemctl restart netdata
```


🌞 Configurer l'alerting avec Discord

```
[amoumour@vbox netdata]$ cd /etc/netdata 2>/dev/null || cd /opt/netdata/etc/netdata
[amoumour@vbox netdata]$ sudo ./edit-config go.d/portcheck.conf
Editing '/etc/netdata/go.d/portcheck.conf' ...
[amoumour@vbox netdata]$ sudo systemctl restart netdata

```

🌞 Tester que ça fonctionne

```
[amoumour@vbox netdata]$ sudo su -s /bin/bash netdata
bash-5.1$ export NETDATA_ALARM_NOTIFY_DEBUG=1
bash-5.1$ /usr/libexec/netdata/plugins.d/alarm-notify.sh test

```
🌞 Euh... tester que ça fonctionne pour de vrai

```

```

🌞 Configurer une alerte quand le port du serveur Web ne répond plus

```

```

🌞 Tester que ça fonctionne !

```

```