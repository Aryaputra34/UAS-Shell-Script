#untuk cek apakah website pnj down atau tidak
#kalo /dev/null aja error nya bakal muncul ke terminal. Pake 2>&1 untuk silence semua output

#masukkan hasil exit code ke variabel http_code_nginx
curl -I localhost > /dev/null 2>&1
http_code_nginx=$(tail -n 1 /var/log/nginx/access.log | awk '{print $9}')


#untuk cek apakah nginx nya atau tidak
#masukkan hasil exit code ke variabel bool_nginx
sudo systemctl status nginx | grep "Active: active" > /dev/null 2>&1
bool_nginx=$?

#variabel isi pesan ataupun subjek
subjek="Monitoring Server TIK PNJ"

#variabel bot telegram
url="https://api.telegram.org/bot$TOKEN/sendMessage"

email="$(pwd)/email1.py"
template="$(pwd)/template_email.py"
db="$(pwd)/db.py"
template_db="$(pwd)/template_db.py"


#copy isi template email
cp $template $email
cp $template_db $db


kirim_email()
{
    python3 $email
}

insert_db(){
    python3 $db
}


#http code 200 dan nginx running
#error diatas 499 adalah error dari sisi server
if [ $http_code_nginx -le 499 ] && [ $bool_nginx -eq 0 ];then
    sukses="Server berjalan dengan baik dan benar"
    echo "$sukses"

    #mengirim pesan melalui bot telegram
    curl -s -X POST $url -d chat_id=$CHAT_ID -d text="$sukses" > /dev/null 2>&1
    echo "Cek Telegram untuk melihat Notifikasi!"

    #mengirim pesan melalui email
    sed -i "s/isi_pesan/$sukses/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    echo "Server berjalan!" >> log.log
    
    query="INSERT INTO server_log VALUES(NULL,'$sukses','{formatted_time}')"
    sed -i "s/isi_pesan/$query/" $db

    insert_db
    kirim_email

#hanya nginx yang running, tetapi http code bukan 200
elif [ $bool_nginx -eq 0 ];then
    nginx="Server running, tetapi terdapat error $http_code_nginx"
    echo "$nginx"

    #mengirim pesan melalui bot telegram
    curl -s -X POST $url -d chat_id=$CHAT_ID -d text="$nginx" > /dev/null 2>&1
    echo "Cek Telegram untuk melihat Notifikasi!"

    #mengirim pesan melalui email
    sed -i "s/isi_pesan/$nginx/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    echo "Web Server berjalan! tetapi terdapat error $http_code_nginx" >> log.log
    query="INSERT INTO server_log VALUES(NULL,'$nginx','{formatted_time}')"
    sed -i "s/isi_pesan/$query/" $db
    insert_db
    kirim_email

else
    #server nginx mati
    down="Server nginx tidak berjalan"
    echo "$down"

    #mengirim pesan melalui bot telegram
    curl -s -X POST $url -d chat_id=$CHAT_ID -d text="$down" > /dev/null 2>&1
    echo "Cek Telegram untuk melihat Notifikasi!"

    #mengirim pesan melalui email
    sed -i "s/isi_pesan/$down/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    echo "Server tidak berjalan!" >> log.log

    query="INSERT INTO server_log VALUES(NULL,'$down','{formatted_time}')"
    sed -i "s/isi_pesan/$query/" $db
    insert_db
    kirim_email

fi


#cek exit code dari http code dan status web server
echo "http code nginx = $http_code_nginx"
echo "bool nginx = $bool_nginx"
echo selesai
