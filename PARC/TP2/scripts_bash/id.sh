#!/bin/bash
# Ptit script qui print des trucs utiles à savoir, j'crois?
# amoumour, 09/12/2024, GMT+2 (16:57)

USER=$(echo $USER)
DATE=$(date +"%m/%d/%y %H/%M/%S")
SHELL_NAME=$(cat /etc/passwd | grep bash | head -n1 | cut -d':' -f7)
OS_NAME=$(source /etc/os-release; echo $NAME $VERSION_ID)
KERNELL_VER=$(uname -r)
FREE_RAM=$(free -mh | grep 'Mem:' | tr -s ' ' | cut -d' ' -f7)
FREE_SPACE_DISK=$(df -mh | grep 'root' | tr -s ' ' | cut -d' ' -f4)
FREE_INODE=$(df -i | grep root | cut -d' ' -f2)
INSTALLED_PACKETS=$(rpm -qa | wc -l)
OPEN_PORTS=$(ss -lntpu4H | wc -l)
PYTHON_PATH=$(which python3)
FIREWALL_ACTIVATED=$(systemctl is-active firewalld)
meow=$(curl https://api.thecatapi.com/v1/images/search | cut -d',' -f2 | cut -d'"' -f4)

echo "Salu a toa ${USER}.
Nouvelle connexion ${DATE}.
Connecté avec le shell ${SHELL_NAME}.
OS : ${OS_NAME} - Kernel : ${KERNELL_VER}
Ressources :
  - ${FREE_RAM} RAM dispo
  - ${FREE_SPACE_DISK} espace disque dispo
  - ${FREE_INODE} fichiers restants
Actuellement : 
  - ${INSTALLED_PACKETS} paquets installés
  - ${OPEN_PORTS} port(s) ouvert(s)
Python est bien installé sur la machine au chemin : ${PYTHON_PATH}
"

# cette partie pour check si le firewall est actif ;p
if [ "$FIREWALL_ACTIVATED" = "active" ]
then
    echo "Firewall est actif"
else
    echo "Firewall est désactiver omg c'est la fin du monde"
fi

# cette partie pour print l'url de chat

echo "Tiens ton image de chat: ${meow}"

