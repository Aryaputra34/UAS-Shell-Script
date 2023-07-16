echo installasi
echo "1. Konfigurasi Email\n2. Konfigurasi Telegram\n3. Konfigurasi MySQL\n4. Konfigurasi Cron Job"
read -p "Pilihan anda : " pilihan

if [ $pilihan -eq 1 ];then

    sh setting_email.sh

elif [ $pilihan -eq 2 ];then

    sh setting_tele.sh

elif [ $pilihan -eq 3 ];then
    sudo ./setting_db.sh

elif [ $pilihan -eq 4 ];then
    sh penjadwalan.sh

else
    echo pilih 1-3 !!
fi
