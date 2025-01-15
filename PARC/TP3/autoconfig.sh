#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Le script doit être lancé en root!"
    exit 1
fi

if [ "$(sestatus | grep "Current mode:" | tr -s ' ' | cut -d':' -f2 | tr -d ' ')" != "permissive" ]; then
    setenforce 0
fi

if [ "$(sestatus | grep "Mode from config file:" | tr -s ' ' | cut -d':' -f2 | tr -d ' ')" != "permissive" ]; then
    sed -i 's/enforcing/permissive/g' /etc/selinux/config
fi


if [ "$(systemctl status firewalld | grep 'Active' | tr -s ' ' | cut -d' ' -f3)" != "active" ]; then
    echo "AAAAH LE FIREWALL EST PAS ACTIF ON VA TOUS MOURIR"
    exit 1
fi

PORT=$(sudo ss -lnpt | grep ':22 ' | awk '{print $4}' | cut -d':' -f2 | head -n 1)
if [ "$PORT" == 22 ]; then
    echo "SSH est config sur l'port 22 je change ca"
    NEW_PORT=0
    while [ "$NEW_PORT" -lt 1024 ] || [ "$NEW_PORT" -gt 65535 ]; do
        NEW_PORT=$RANDOM
    done
    firewall-cmd --permanent --add-port=${NEW_PORT}/tcp
    firewall-cmd --permanent --remove-port=22/tcp
    firewall-cmd --reload

    sed -i "s/Port 22/Port ${NEW_PORT}/g" /etc/ssh/sshd_config
    systemctl restart sshd


    echo "SSH tourne mtn sur le port ${NEW_PORT}"
else
    echo "Pti message de succès! Le SSH tourne déjà sur un autre port."
fi

HOSTNAME=$(hostname)
if [[ "$HOSTNAME" == "localhost" || "$HOSTNAME" == "vbox" ]]; then
    if [ -z "$1" ]; then
        echo "Hop hop hop, ça prend un argument : le hostname. Au charbon !"
        exit 1
    fi
    hostnamectl set-hostname "$1"
fi

if ! getent group wheel | grep "$(whoami)"; then
    echo "Nope, t'es pas dans le groupe wheel."
    usermod -aG wheel $(whoami)
fi
