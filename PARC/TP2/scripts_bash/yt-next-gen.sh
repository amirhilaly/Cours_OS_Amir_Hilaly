#!/bin/bash
# Ptit code qui permet de télécharger une vidéo youtube, elle prend un argument qui est l'URL
# Amir HILALY, 15/12/2024


while read Ligne
do
  if [[ ! $Ligne =~ ^https://www\.youtube\.com/watch\?v=([a-z]|[A-Z]|[0-9]|'_'|'-'){11}$ ]]; then
    echo "Ceci n'est une URL youtube"
    exit 1
  else
     if [ ! -f "/var/log/yt/downloads.log" ]; then
       echo "Oulah, y'a pas l'fichier /var/log/yt, y'é passé ou?!"
       exit 1
     fi

     VIDEO_TITLE=$(yt-dlp --quiet --no-warnings --get-title $Ligne)
     VIDEO_TITLE="${VIDEO_TITLE// /_}"

     mkdir /opt/yt/downloads/${VIDEO_TITLE}
     yt-dlp --quiet --no-warnings --get-description "$Ligne" >> /opt/yt/downloads/${VIDEO_TITLE}/description
     yt-dlp -f mp4 --quiet --no-warnings -o "/opt/yt/downloads/${VIDEO_TITLE}/${VIDEO_TITLE}.mp4" "$Ligne"

     echo "Video ${Ligne} was downloaded.
     File path: /opt/yt/downloads/${VIDEO_TITLE}/${VIDEO_TITLE}.mp4"

     echo "${date+ "%y/%m/%d %H/%M/%S"} Video ${Ligne} was downloaded. File path: /opt/yt/downloads/${VIDEO_TITLE}/${VIDEO_TITLE}.mp4" >> /var/log/yt/downloads.log
  fi
done < test.txt

exit