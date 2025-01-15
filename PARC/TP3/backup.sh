#!/bin/bash
DIR = "/srv/music"
DEST_FILE="/mnt/music_backup/music_$(date +%y%m%d_%H%M%S).tar.gz"
tar -czf "$DEST_FILE" -C "$DIR" .
if [ $? -eq 0 ]; then
    echo "Voila, sauvegarde faite !"
else
    echo "Erreur lors de la sauvegarde."
fi