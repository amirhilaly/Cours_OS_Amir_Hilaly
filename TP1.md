# TP 1:

### Lister tous les processus en cours d'exécution sur votre machine, on doit voir apparaître:
-le nom de chaque processus  
-son identifiant unique (un nombre entier)

```Get-Process | Select-Object Name, Id```


### Trouver les 3 processus qui ont le plus petit identifiant leur nom et leur identifiant, ce sont forcément des processus très importants : les premiers lancés par votre OS !
pour le compte-rendu, isolez les 3 lignes qui les concernent dans la liste de tous les processus

```
Get-Process | Sort-Object Id | Select-Object -First 3 -Property Name, Id

Name          Id
----          ---
Idle
System
Secure System
```



### Lister tous les services de la machine... avec une commande, lister tous les services qui sont en cours d'exécution

```
Get-Service | Where-Object { $_.Status -eq 'Running' }

Status   Name               DisplayName
------   ----               -----------
Running  Appinfo            Informations d’application
Running  AppXSvc            Service de déploiement AppX (AppXSVC)
Running  ArmouryCrateCon... Armoury Crate Control Interface
Running  ArmouryCrateSer... ARMOURY CRATE Service
Running  AsusAppService     ASUS App Service
Running  AsusCertService    AsusCertService
Running  ASUSOptimization   ASUS Optimization
Running  ASUSSoftwareMan... ASUS Software Manager
Running  ASUSSwitch         ASUS Switch
Running  ASUSSystemAnalysis ASUS System Analysis
Running  ASUSSystemDiagn... ASUS System Diagnosis
Running  AudioEndpointBu... Générateur de points de terminaison...
Running  Audiosrv           Audio Windows
Running  Aura Wallpaper ... Aura Wallpaper Service
Running  BFE                Moteur de filtrage de base
Running  BrokerInfrastru... Service d’infrastructure des tâches...

```


### ...avec une autre commande, lister tous les services qui existent mais ne sont pas lancés
```
PS C:\users\amoum\OneDrive\Bureau> Get-Service | Where-Object { $_.Status -ne 'Running' }

Status   Name               DisplayName
------   ----               -----------
Stopped  AarSvc_1c4801a4    Agent Activation Runtime_1c4801a4
Stopped  AJRouter           Service de routeur AllJoyn
Stopped  ALG                Service de la passerelle de la couc...
Stopped  AppIDSvc           Identité de l’application
Stopped  AppReadiness       Préparation des applications
```

## RAM

### Afficher la quantité de RAM totale de la machine
```
PS C:\users\amoum\OneDrive\Bureau> (Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB
15,6296272277832
```

### Afficherla quantité de RAM libre sur la machine
```
PS C:\users\amoum\OneDrive\Bureau> (Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory / 1024 / 1024
7,19990158081055
```


## CPU

### Afficher l'utilisation du CPU (Ici, je le fais en pourcentage)
```
PS C:\> Get-WmiObject -Class Win32_Processor | Select-Object Name, LoadPercentage

Name                                 LoadPercentage
----                                 --------------
12th Gen Intel(R) Core(TM) i7-12650H              2

```

## Périphériques

### Lister les périphériques de stockage
### Je veux voir les disques durs branchés à votre PC, pas les partitions
### genre je veux pas voir C: dans le retour de la commande, plutôt la marque du disque dur, et sa taille
```PS C:\> Get-Disk

Number Friendly Name            Serial Number                    HealthStatus         OperationalStatus      Total Size Partition
                                                                                                                        Style
------ -------------            -------------                    ------------         -----------------      ---------- ----------
0      NVMe INTEL SSDPEKNU512GZ 0000_0000_0100_0000_E4D2_5C96... Healthy              Online                  476.94 GB GPT
```


lister les partitions du système
sur Windows, les partitions sont notamment C:, D: etc, mais y'en a d'autres qui ne sont pas utilisées actuellement et qui n'utilisent donc pas de lettres comme D:
```
PS C:\> Get-Partition | Select-Object -Property PartitionNumber, DriveLetter, Size, PartitionType

PartitionNumber DriveLetter         Size PartitionType
--------------- -----------         ---- -------------
              1               272629760
              2                16777216
              3           C 484989804032
              4               786432000
              5             25769803776
              6               272629760
```



### Afficher l'espace disque restant sur votre partition principale
sur Windows, c'est C: la partition principale
```PS C:\> Get-PSDrive

Name           Used (GB)     Free (GB) Provider      Root                                                          CurrentLocation
----           ---------     --------- --------      ----                                                          ---------------
Alias                                  Alias
C                 146,82        304,87 FileSystem    C:\
Cert                                   Certificate   \
Env                                    Environment
Function                               Function
HKCU                                   Registry      HKEY_CURRENT_USER
HKLM                                   Registry      HKEY_LOCAL_MACHINE
Variable                               Variable
WSMan                                  WSMan
```




## Cartes réseau

### Afficher la liste des cartes réseau de votre PC
on doit voit apparaître leur adresse IP et leur nom
```PS C:\> Get-NetAdapter

Name                      InterfaceDescription                    ifIndex Status       MacAddress             LinkSpeed
----                      --------------------                    ------- ------       ----------             ---------
Wi-Fi                     Intel(R) Wi-Fi 6 AX201 160MHz                21 Up           4C-03-4F-DA-0A-93       400 Mbps
Ethernet                  Intel(R) Ethernet Connection (16) I2...      14 Disconnected A0-36-BC-30-05-68          0 bps
Ethernet 4                VirtualBox Host-Only Ethernet Adapter         6 Up           0A-00-27-00-00-06         1 Gbps
```


### Avec leurs addresses IP:
```
PS C:\> Get-NetAdapter | ForEach-Object {
>>     $adapter = $_
>>     $ipAddresses = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex | Select-Object -ExpandProperty IPAddress
>>     [PSCustomObject]@{
>>         Name        = $adapter.Name
>>         Status      = $adapter.Status
>>         MacAddress  = $adapter.MacAddress
>>         IPAddresses = $ipAddresses -join ', '
>>     }
>> } | Format-Table -AutoSize

Name       Status       MacAddress        IPAddresses
----       ------       ----------        -----------
Wi-Fi      Up           4C-03-4F-DA-0A-93 fe80::27a5:6d63:15d8:4a3c%21, 10.3.220.87
Ethernet   Disconnected A0-36-BC-30-05-68 fe80::355a:9ae3:a8:80e6%14, 169.254.174.131
Ethernet 4 Up           0A-00-27-00-00-06 fe80::c47d:b560:3282:49aa%6, 192.168.56.1
```


## Connexions réseau

### Lister les connexions réseau actuellement en cours
"actuellement en cours" c'est qu'elles sont dans l'état "établi" ou "established" en anglais
on doit voir apparaître :
l'adresse IP du serveur auquel vous êtes connectés
le nom et/ou l'identifiant du processus responsable de cette connexion
```
Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' } | ForEach-Object {
    $connection = $_
    $process = Get-Process -Id $connection.OwningProcess
    [PSCustomObject]@{
        LocalAddress  = $connection.LocalAddress
        LocalPort     = $connection.LocalPort
        RemoteAddress = $connection.RemoteAddress
        RemotePort    = $connection.RemotePort
        State         = $connection.State
        ProcessName   = $process.Name
        ProcessId     = $connection.OwningProcess
    }
} | Format-Table -AutoSize

LocalAddress LocalPort RemoteAddress   RemotePort       State ProcessName                    ProcessId
------------ --------- -------------   ----------       ----- -----------                    ---------
127.0.0.1        49741 127.0.0.1            49740 Established WUDFHost                            1568
127.0.0.1        49740 127.0.0.1            49741 Established WUDFHost                            1568
127.0.0.1        49734 127.0.0.1            49733 Established ipfsvc                              5824
127.0.0.1        49733 127.0.0.1            49734 Established ipfsvc                              5824
127.0.0.1        49727 127.0.0.1            49726 Established WUDFHost                            1464
127.0.0.1        49726 127.0.0.1            49727 Established WUDFHost                            1464
127.0.0.1        49683 127.0.0.1            13030 Established ROGLiveService                      5760
10.3.220.87      49523 20.199.120.85          443 Established svchost                             5684
127.0.0.1        40277 127.0.0.1            40267 Established steamwebhelper                     10928
127.0.0.1        40276 127.0.0.1            40269 Established steamwebhelper                     10928
127.0.0.1        40269 127.0.0.1            40276 Established steam                              17688
127.0.0.1        40267 127.0.0.1            40277 Established steam                              17688
127.0.0.1        40255 127.0.0.1             9012 Established ArmouryCrate.UserSessionHelper     16712
127.0.0.1        40253 127.0.0.1            17532 Established ArmouryCrate.UserSessionHelper     16712
127.0.0.1        40242 127.0.0.1             1042 Established ArmourySocketServer                 3568
127.0.0.1        40241 127.0.0.1             1042 Established AcPowerNotification                20044
10.3.220.87      24348 51.132.193.105         443 Established Code                               27468
10.3.220.87      23679 35.186.224.45          443 Established chrome                             15872
10.3.220.87      23675 162.159.134.234        443 Established chrome                             15872
10.3.220.87      23665 142.250.110.188       5228 Established chrome                             15872
10.3.220.87      21650 20.199.120.85          443 Established OneDrive                           10536
127.0.0.1        21464 127.0.0.1            21463 Established NVDisplay.Container                11556
127.0.0.1        21463 127.0.0.1            21464 Established NVDisplay.Container                11556
127.0.0.1        17532 127.0.0.1            40253 Established ArmouryCrate.Service               21268
127.0.0.1        13030 127.0.0.1            49683 Established ROGLiveService                      5760
127.0.0.1         9012 127.0.0.1            40255 Established ArmourySocketServer                 3568
127.0.0.1         1042 127.0.0.1            40241 Established asus_framework                     20712
127.0.0.1         1042 127.0.0.1            40242 Established asus_framework                     20712
```



### Lister les utilisateurs de la machine
### on devrait voir au moins :
### votre utilisateur
### l'utilisateur qui est administrateur sur la machine
```
PS C:\> Get-LocalUser

Name               Enabled Description
----               ------- -----------
Administrateur     False   Compte d’utilisateur d’administration
amoum              True
DefaultAccount     False   Compte utilisateur géré par le système.
Invité             False   Compte d’utilisateur invité
WDAGUtilityAccount False   Compte d’utilisateur géré et utilisé par le système pour les scénarios Windows Defender Application …
```



### Lister les processus en cours d'exécution
### cette fois, on doit voir apparaître en plus le nom de l'utilisateur qui a lancé chacun d'entre eux
```
Get-Process | Select-Object Id, ProcessName, @{Name='User';Expression={(Get-WmiObject -Query "Select * from Win32_Process where ProcessId = $($_.Id)").GetOwner().User}} | Format-Table -AutoSize

   Id ProcessName                    User
   -- -----------                    ----
 3416 ACCIMonitor                    amoum
20044 AcPowerNotification            amoum
 4308 AggregatorHost
 5820 ApplicationFrameHost           amoum
21268 ArmouryCrate.Service
16712 ArmouryCrate.UserSessionHelper amoum
 5544 ArmouryCrateControlInterface
 3568 ArmourySocketServer            amoum
17300 ArmourySwAgent                 amoum
 1228 AsHotplugCtrl                  amoum
15568 asus_framework                 amoum
20712 asus_framework                 amoum
(il y'a beaucoup d'lignes j'ai raccourcis)
```


### Sur un fichier random qui se trouve dans votre dossier Téléchargements/

### déterminer quel utilisateur est le propriétaire du fichier
### chaque fichier a un propriétaire, qui peut tout faire sur le fichier, et empêcher les autres utilisateurs de le lire
```
PS C:\users\amoum\Downloads> Get-Acl -Path "$env:USERPROFILE\Downloads\zzz.py" | Select-Object Owner

Owner
-----
AMIR\amoum
```

## Uptime

### afficher l'heure/la date de l'allumage de la machine
```
(Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
PS C:\users\amoum\Downloads> (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime

lundi 21 octobre 2024 20:28:35
(oui, on est le 4 novembre oui oui, le pc il a chaud je pense la mdr)
```

## Device

## Afficher le modèle du processeur de la machine
```
PS C:\users\amoum\Downloads> (Get-CimInstance -ClassName Win32_Processor).Name

12th Gen Intel(R) Core(TM) i7-12650H
```

## Version

### Afficher le nom et la version exacte de votre OS
```
PS C:\users\amoum\Downloads> (Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version)

Caption                      Version
-------                      -------
Microsoft Windows 11 Famille 10.0.22631
```


## Mise à jour

## Afficher la date et l'heure de la dernière mise à jour
```
(Get-HotFix | Select-Object -First 1).InstalledOn
mercredi 9 octobre 2024 00:00:00
```



### Lister les connexions actives
```
PS C:\users\amoum\Downloads> Get-NetTCPConnection | ForEach-Object {
>>     $process = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
>>     [PSCustomObject]@{
>>         LocalAddress  = $_.LocalAddress
>>         LocalPort     = $_.LocalPort
>>         RemoteAddress = $_.RemoteAddress
>>         RemotePort    = $_.RemotePort
>>         State         = $_.State
>>         ProcessId     = $_.OwningProcess
>>         ProcessName   = if ($process) { $process.Name } else { "N/A" }
>>     }
>> } | Format-Table -AutoSize

LocalAddress LocalPort RemoteAddress   RemotePort       State ProcessId ProcessName
------------ --------- -------------   ----------       ----- --------- -----------
::               49680 ::                       0      Listen      1156 services
::1              49679 ::                       0      Listen      6584 jhi_service
::               49676 ::                       0      Listen      4948 spoolsv
::               49673 ::                       0      Listen      3216 svchost
::               49670 ::                       0      Listen      2592 svchost
::               49665 ::                       0      Listen      1084 wininit
::               49664 ::                       0      Listen      1192 lsass
::1              42050 ::                       0      Listen      7076 Microsoft.SharePoint
::                9013 ::                       0      Listen     25016 ArmourySocketServer
::                9012 ::                       0      Listen     25016 ArmourySocketServer
::                1043 ::                       0      Listen     25704 asus_framework
::                1042 ::                       0      Listen     25704 asus_framework
::                 445 ::                       0      Listen         4 System
::                 135 ::                       0      Listen      1412 svchost
0.0.0.0          49741 0.0.0.0                  0       Bound      1568 WUDFHost
0.0.0.0          49734 0.0.0.0                  0       Bound      5824 ipfsvc
0.0.0.0          49727 0.0.0.0                  0       Bound      1464 WUDFHost
0.0.0.0          49683 0.0.0.0                  0       Bound      5760 ROGLiveService
0.0.0.0          49508 0.0.0.0                  0       Bound      5684 svchost
0.0.0.0          39564 0.0.0.0                  0       Bound      6184 chrome
0.0.0.0          39540 0.0.0.0                  0       Bound      8756 OneDrive
0.0.0.0          39539 0.0.0.0                  0       Bound      6184 chrome
0.0.0.0          39536 0.0.0.0                  0       Bound      8756 OneDrive
0.0.0.0          39518 0.0.0.0                  0       Bound      6184 chrome
0.0.0.0          39491 0.0.0.0                  0       Bound      4012 SearchHost
0.0.0.0          39490 0.0.0.0                  0       Bound      4012 SearchHost
0.0.0.0          39489 0.0.0.0                  0       Bound      4012 SearchHost
0.0.0.0          39485 0.0.0.0                  0       Bound      4012 SearchHost
0.0.0.0          39476 0.0.0.0                  0       Bound      4012 SearchHost
0.0.0.0          39473 0.0.0.0                  0       Bound      6184 chrome
0.0.0.0          39472 0.0.0.0                  0       Bound      4012 SearchHost
0.0.0.0          39471 0.0.0.0                  0       Bound      6184 chrome
0.0.0.0          39463 0.0.0.0                  0       Bound      4012 SearchHost
0.0.0.0          38648 0.0.0.0                  0       Bound     27828 SystemSettings
0.0.0.0          38243 0.0.0.0                  0       Bound      3348 steamwebhelper
0.0.0.0          38242 0.0.0.0                  0       Bound      3348 steamwebhelper
0.0.0.0          38072 0.0.0.0                  0       Bound     12600 HxOutlook
0.0.0.0          38071 0.0.0.0                  0       Bound     12600 HxOutlook
0.0.0.0          38070 0.0.0.0                  0       Bound     12600 HxOutlook
0.0.0.0          37137 0.0.0.0                  0       Bound     27760 NVDisplay.Container
0.0.0.0          23991 0.0.0.0                  0       Bound     14252 ArmouryCrate.UserSessionHelper
0.0.0.0          23990 0.0.0.0                  0       Bound     14252 ArmouryCrate.UserSessionHelper
0.0.0.0          23981 0.0.0.0                  0       Bound     25016 ArmourySocketServer
0.0.0.0          23980 0.0.0.0                  0       Bound      8876 AcPowerNotification
127.0.0.1        49741 127.0.0.1            49740 Established      1568 WUDFHost
127.0.0.1        49740 127.0.0.1            49741 Established      1568 WUDFHost
127.0.0.1        49734 127.0.0.1            49733 Established      5824 ipfsvc
127.0.0.1        49733 127.0.0.1            49734 Established      5824 ipfsvc
127.0.0.1        49727 127.0.0.1            49726 Established      1464 WUDFHost
127.0.0.1        49726 127.0.0.1            49727 Established      1464 WUDFHost
127.0.0.1        49683 127.0.0.1            13030 Established      5760 ROGLiveService
0.0.0.0          49680 0.0.0.0                  0      Listen      1156 services
0.0.0.0          49676 0.0.0.0                  0      Listen      4948 spoolsv
0.0.0.0          49673 0.0.0.0                  0      Listen      3216 svchost
0.0.0.0          49670 0.0.0.0                  0      Listen      2592 svchost
0.0.0.0          49665 0.0.0.0                  0      Listen      1084 wininit
0.0.0.0          49664 0.0.0.0                  0      Listen      1192 lsass
10.3.220.87      49508 40.83.247.108          443 Established      5684 svchost
10.3.220.87      39594 185.25.182.52          443    TimeWait         0 Idle
10.3.220.87      39593 155.133.250.20         443    TimeWait         0 Idle
10.3.220.87      39592 155.133.248.43         443    TimeWait         0 Idle
10.3.220.87      39584 2.18.131.137           443    TimeWait         0 Idle
10.3.220.87      39564 104.18.32.47           443 Established      6184 chrome
10.3.220.87      39561 96.17.207.81           443    TimeWait         0 Idle
10.3.220.87      39540 52.105.31.41           443 Established      8756 OneDrive
10.3.220.87      39539 172.65.251.78          443 Established      6184 chrome
10.3.220.87      39536 40.83.247.108          443 Established      8756 OneDrive
10.3.220.87      39518 64.233.166.188         443 Established      6184 chrome
10.3.220.87      39500 52.182.143.215         443    TimeWait         0 Idle
10.3.220.87      39491 13.107.253.254         443   CloseWait      4012 SearchHost
10.3.220.87      39473 35.186.224.45          443 Established      6184 chrome
10.3.220.87      39472 152.199.19.161         443 Established      4012 SearchHost
10.3.220.87      39471 162.159.136.234        443 Established      6184 chrome
10.3.220.87      39463 13.107.246.42          443   CloseWait      4012 SearchHost
127.0.0.1        38243 127.0.0.1            38234 Established      3348 steamwebhelper
127.0.0.1        38242 127.0.0.1            38237 Established      3348 steamwebhelper
127.0.0.1        38237 127.0.0.1            38242 Established     27684 steam
127.0.0.1        38237 0.0.0.0                  0      Listen     27684 steam
127.0.0.1        38234 127.0.0.1            38243 Established     27684 steam
127.0.0.1        38234 0.0.0.0                  0      Listen     27684 steam
10.3.220.87      38071 192.229.221.95          80   CloseWait     12600 HxOutlook
10.3.220.87      38070 52.109.28.46           443   CloseWait     12600 HxOutlook
127.0.0.1        37137 127.0.0.1            37136 Established     27760 NVDisplay.Container
127.0.0.1        37136 127.0.0.1            37137 Established     27760 NVDisplay.Container
127.0.0.1        27060 0.0.0.0                  0      Listen     27684 steam
0.0.0.0          27036 0.0.0.0                  0      Listen     27684 steam
127.0.0.1        24830 0.0.0.0                  0      Listen         4 System
127.0.0.1        23991 127.0.0.1             9012 Established     14252 ArmouryCrate.UserSessionHelper
127.0.0.1        23990 127.0.0.1            17532 Established     14252 ArmouryCrate.UserSessionHelper
127.0.0.1        23981 127.0.0.1             1042 Established     25016 ArmourySocketServer
127.0.0.1        23980 127.0.0.1             1042 Established      8876 AcPowerNotification
127.0.0.1        22112 0.0.0.0                  0      Listen      5760 ROGLiveService
127.0.0.1        17945 0.0.0.0                  0      Listen     14252 ArmouryCrate.UserSessionHelper
127.0.0.1        17532 127.0.0.1            23990 Established     21268 ArmouryCrate.Service
127.0.0.1        17532 0.0.0.0                  0      Listen     21268 ArmouryCrate.Service
127.0.0.1        13032 0.0.0.0                  0      Listen     14252 ArmouryCrate.UserSessionHelper
127.0.0.1        13031 0.0.0.0                  0      Listen     14252 ArmouryCrate.UserSessionHelper
127.0.0.1        13030 127.0.0.1            49683 Established      5760 ROGLiveService
127.0.0.1        13030 0.0.0.0                  0      Listen      5760 ROGLiveService
127.0.0.1        13010 0.0.0.0                  0      Listen     21268 ArmouryCrate.Service
127.0.0.1        11001 0.0.0.0                  0      Listen      5636 AuraWallpaperService
127.0.0.1         9012 127.0.0.1            23991 Established     25016 ArmourySocketServer
0.0.0.0           5040 0.0.0.0                  0      Listen      8520 svchost
127.0.0.1         1042 127.0.0.1            23981 Established     25704 asus_framework
127.0.0.1         1042 127.0.0.1            23980 Established     25704 asus_framework
192.168.56.1       139 0.0.0.0                  0      Listen         4 System
10.3.220.87        139 0.0.0.0                  0      Listen         4 System
0.0.0.0            135 0.0.0.0                  0      Listen      1412 svchost
la j'ai pas raccourcis dcp
```



### Choisir l'une des lignes comme cible, une sur laquelle vous souhaiterez obtenir plus d'infos
### notez en particulier :

### L'adresse IP que vous avez utilisé pour vous connecter à ce serveur (dans une colonne)
### L'adresse IP du serveur auquel vous êtes connectés (dans l'autre colonne :d)
### Le nom/l'identifiant du programme qui fait cette connexion
```
PS C:\users\amoum\Downloads> $targetIP = "172.65.251.78"
PS C:\users\amoum\Downloads> Get-NetTCPConnection | Where-Object { $_.RemoteAddress -eq $targetIP } | ForEach-Object {
>>     $process = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
>>     [PSCustomObject]@{
>>         LocalAddress  = $_.LocalAddress
>>         LocalPort     = $_.LocalPort
>>         RemoteAddress = $_.RemoteAddress
>>         RemotePort    = $_.RemotePort
>>         State         = $_.State
>>         ProcessId     = $_.OwningProcess
>>         ProcessName   = if ($process) { $process.Name } else { "N/A" }
>>     }
>> } | Format-Table -AutoSize

LocalAddress LocalPort RemoteAddress RemotePort       State ProcessId ProcessName
------------ --------- ------------- ----------       ----- --------- -----------
10.3.220.87      39539 172.65.251.78        443 Established      6184 chrome
```



## En apprendre + sur le programme
### déterminer le chemin vers le programme (vers le fichier .exe sous Windows)
### genre le dossier où il se trouve quoi
```
PS C:\users\amoum\Downloads> $processId = 6184
PS C:\users\amoum\Downloads> $process = Get-Process -Id $processId
PS C:\users\amoum\Downloads> $processPath = $process.Path
PS C:\users\amoum\Downloads> $processPath
C:\Program Files\Google\Chrome\Application\chrome.exe
```


### Déterminer qui est l'utilisateur qui est propriétaire du programme (le fichier exécutable)



## En apprendre + sur l'adresse IP
```
PS C:\Users\amoum> Invoke-RestMethod -Method Get -Uri http://ip-api.com/json/13.37.13.37


status      : success
country     : France
countryCode : FR
region      : IDF
regionName  : Île-de-France
city        : Paris
zip         : 75000
lat         : 48,8566
lon         : 2,35222
timezone    : Europe/Paris
isp         : Amazon Technologies Inc.
org         : AWS EC2 (eu-west-3)
as          : AS16509 Amazon.com, Inc.
query       : 13.37.13.37

🌞 Délai

mesurer la latence entre vous et ce serveur
ça se fait en utilisant la commande ping : ping <ADRESSE IP>

par exemple, pour envoyer des ptits Pings vers l'adresse IP 13.37.13.37 : ping 13.37.13.37

généralement vous avez une valeur en millisecondes : le temps qu'un message Ping fasse l'aller-retour entre vous et le serveur


PS C:\Users\amoum> ping 13.37.13.37

Envoi d’une requête 'Ping'  13.37.13.37 avec 32 octets de données :
Délai d’attente de la demande dépassé.
Délai d’attente de la demande dépassé.
Délai d’attente de la demande dépassé.
Délai d’attente de la demande dépassé.

Statistiques Ping pour 13.37.13.37:
    Paquets : envoyés = 4, reçus = 0, perdus = 4 (perte 100%),
(je sais pas ce qu'il c'est passer, mais bon)
```