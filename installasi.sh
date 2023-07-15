echo installasi
echo "1. Konfigurasi Email\n2. Konfigurasi Telegram\n3. Konfigurasi Cronjob"
read -p "Pilihan anda : " pilihan

if [ $pilihan -eq 1 ];then

    sh setting_email.sh

elif [ $pilihan -eq 2 ];then

    sh setting_tele.sh

elif [ $pilihan -eq 3 ];then
    sh penjadwalan.sh

else
    echo pilih 1-3 !!
fi
