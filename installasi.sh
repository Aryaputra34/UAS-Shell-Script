#template_db
sed -i "/template_database=/d" cek-server.sh
sed -i "/#absolute/a template_database=\"$PWD\/template_db.py\"" cek-server.sh
#db
sed -i "/db=/d" cek-server.sh
sed -i "/#absolute/a db=\"$PWD\/db.py\"" cek-server.sh
#template
sed -i "/template=/d" cek-server.sh
sed -i "/#absolute/a template=\"$PWD\/template_email.py\"" cek-server.sh
#email
sed -i "/email=/d" cek-server.sh
sed -i "/#absolute/a email=\"$PWD\/email1.py\"" cek-server.sh


echo installasi
echo "1. Konfigurasi Email\n2. Konfigurasi Telegram\n3. Konfigurasi Cronjob"
read -p "Pilihan anda : " pilihan

if [ $pilihan -eq 1 ];then

    sh setting_email.sh

elif [ $pilihan -eq 2 ];then

    sh setting_tele.sh

elif [ $pilihan -eq 3 ];then
    echo "installasi crontab"

else
    echo pilih 1-3 !!
fi
