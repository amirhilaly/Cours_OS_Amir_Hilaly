🌞 Dérouler le script autoconfig.sh développé à la partie I

```
[amoumour@monitoring ~]$ sudo ./autoconfig.sh
[sudo] password for amoumour:
Pti message de succès! Le SSH tourne déjà sur un autre port.
wheel:x:10:amoumour,root
```

🌞 Installer Netdata

```
[amoumour@monitoring ~]$ curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --no-updates --stable-channel --disable-telemetry
```


🌞 Ajouter un check TCP

```
[amoumour@monitoring netdata]$ cd /etc/netdata 2>/dev/null || cd /opt/netdata/etc/netdata
[amoumour@monitoring netdata]$ sudo ./edit-config health_alarm_notify.conf
Copying '/etc/netdata/../../usr/lib/netdata/conf.d//health_alarm_notify.conf' to '/etc/netdata//health_alarm_notify.conf' ...
Editing '/etc/netdata/health_alarm_notify.conf' ...
```

🌞 Ajout d'une alerte Discord

```

```