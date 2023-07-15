#!/bin/bash
echo "Konfigurasi Token dan Chat ID Telegram"
read -p "Token: " TOKEN
read -p "Chat ID: " CHAT_ID

cat /etc/environment | grep TOKEN >> /dev/null
bool=$?

delete(){
 sed -i '/TOKEN/d' /etc/environment
 sed -i '/CHAT_ID/d' /etc/environment
}
insert(){
    sed -i -e '$aexport TOKEN=\"'$TOKEN'\"' /etc/environment
    sed -i -e '$aexport CHAT_ID=\"'$CHAT_ID'\"' /etc/environment
}

if [ $bool -eq 0 ];then
    delete
    echo "Variabel lama telah dihapus"
fi

insert

echo "--- Token dan Chat ID Telegram sudah disimpan pada variabel environment"
echo "Variabel TOKEN = $TOKEN"
echo "Variabel CHAT_ID = $CHAT_ID"
