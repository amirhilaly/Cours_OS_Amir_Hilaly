# Ptit code qui permet de télécharger une vidéo youtube, elle prend un argument qui est l'URL
# Amir HILALY, 15/12/2024

if [ -z "$1" ]; then
  echo "Hop hop hop, ca prend un argument, l'URL, au charbon!"
  exit 1
fi

if [ ! -f "/var/log/yt/downloads.log" ]; then
  echo "Oulah, y'a pas l'fichier /var/log/yt, y'é passé ou?!"
  exit 1
fi


VIDEO_TITLE=$(yt-dlp --quiet --no-warnings --get-title $1)
VIDEO_TITLE="${VIDEO_TITLE// /_}"




mkdir /opt/yt/downloads/${VIDEO_TITLE}
yt-dlp --quiet --no-warnings --get-description "$1" >> /opt/yt/downloads/${VIDEO_TITLE}/description
yt-dlp -f mp4 --quiet --no-warnings -o "/opt/yt/downloads/${VIDEO_TITLE}/${VIDEO_TITLE}.mp4" "$1"

echo "Video ${1} was downloaded.
File path: /opt/yt/downloads/${VIDEO_TITLE}/${VIDEO_TITLE}.mp4"

echo "${date+ "%y/%m/%d %H/%M/%S"} Video ${1} was downloaded. File path: /opt/yt/downloads/${VIDEO_TITLE}/${VIDEO_TITLE}.mp4" >> /var/log/yt/downloads.log