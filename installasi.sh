#!/bin/bash
if [ "$EUID" -ne 0 ];then
    echo harus sudo!!!
    exit
fi

#template_db
sed -i "/template_database=/d" cek-server.sh
sed -i "/#absolute/a template_database=\"$PWD\/template_db.py\"" cek-server.sh
#db
sed -i "/basisdata=/d" cek-server.sh
sed -i "/#absolute/a basisdata=\"$PWD\/db.py\"" cek-server.sh
#template
sed -i "/template=/d" cek-server.sh
sed -i "/#absolute/a template=\"$PWD\/template_email.py\"" cek-server.sh
#email
sed -i "/email=/d" cek-server.sh
sed -i "/#absolute/a email=\"$PWD\/email1.py\"" cek-server.sh

sh change_path_in_database.sh 


while true; do
clear
echo installasi

echo "1. Konfigurasi Email"
echo "2. Konfigurasi Telegram"
echo "3. Konfigurasi MySQL"
echo "4. Konfigurasi Cron Job"
echo "5. Keluar"

read -p "Pilihan anda : " pilihan

if [ $pilihan -eq 1 ];then

    sh setting_email.sh
    echo ""
    read -p "Press Enter to Continue..."

elif [ $pilihan -eq 2 ];then

    sh setting_tele.sh
    echo ""
    read -p "Press Enter to Continue..."

elif [ $pilihan -eq 3 ];then
    sh setting_db.sh
    echo ""
    read -p "Konfigurasi Database telah berhasil!"

elif [ $pilihan -eq 4 ];then
    sh penjadwalan.sh

elif [ $pilihan -eq 5 ];then
    exit 0

else
    echo pilih 1-4 !!
fi
done