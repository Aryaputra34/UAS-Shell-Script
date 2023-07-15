#untuk cek apakah website pnj down atau tidak
#kalo /dev/null aja error nya bakal muncul ke terminal. Pake 2>&1 untuk silence semua output
#ping elearning.pnj.ac.idd -c 5 > /dev/null 2>&1

#masukkan hasil exit code ke variabel bool_ping
ping elearning.pnj.ac.id -c 1 > /dev/null 2>&1
bool_ping=$?

#untuk cek apakah nginx nya running atau tidak
#sudo systemctl status nginx | grep "Active: active" > /dev/null 2>&1

#masukkan hasil exit code ke variabel bool_nginx
sudo systemctl status nginx | grep "Active: active" > /dev/null 2>&1
bool_nginx=$?

#variabel isi pesan ataupun subjek
sukses="berhasil ping dan nginx"
nginx="berhasil nginx gagal ping"
ping="berhasil ping gagal nginx"
down="server mati, tidak bisa ping ke website dan web server down"
subjek="Monitoring Server TIK PNJ"

#variabel bot telegram
TOKEN=$"TOKEN"
URL="https://api.telegram.org/bot$token/sendMessage"
CHAT_ID="$CHAT_ID"

#path
email="/home/zoc/Documents/Kuliah/UAS-Shell-Script/email1.py"
template="/home/zoc/Documents/Kuliah/UAS-Shell-Script/template_email.py"
db="/home/zoc/Documents/Kuliah/UAS-Shell-Script/db.py"
template_db="/home/zoc/Documents/Kuliah/UAS-Shell-Script/template_db.py"

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


#bisa ping dan nginx
if [ $bool_ping -eq 0 ] && [ $bool_nginx -eq 0 ];then

    echo "$sukses"
#mengirim pesan melalui bot telegram
    curl -s -X POST $url -d chat_id=$id_chat -d text="$sukses" > /dev/null 2>&1
#mengirim pesan melalui email
    sed -i "s/isi_pesan/$sukses/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    echo "Server berjalan!" >> log.log
    query="INSERT INTO server_log VALUES(NULL,'$sukses','{formatted_time}')"
    sed -i "s/isi_pesan/$query/" $db
    insert_db
    kirim_email

    

#hanya nginx
elif [ $bool_nginx -eq 0 ];then

    echo "$nginx"
#mengirim pesan melalui bot telegram
    curl -s -X POST $url -d chat_id=$id_chat -d text="$nginx" > /dev/null 2>&1
#mengirim pesan melalui email
    sed -i "s/isi_pesan/$nginx/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    echo "Gagal Ping dan Web Server berjalan!" >> log.log
    query="INSERT INTO server_log VALUES(NULL,'$nginx','{formatted_time}')"
    sed -i "s/isi_pesan/$query/" $db
    insert_db
    kirim_email

#hanya ping
# elif [ $bool_ping -eq 0 ];then

#     echo "$ping"
#mengirim pesan melalui bot telegram
     # curl -s -X POST $url -d chat_id=$id_chat -d text="$ping" > /dev/null 2>&1
#mengirim pesan melalui email
#     sed -i "s/isi_pesan/$ping/" $email
#     sed -i "s/isi_subjek/$subjek/" $email
#     echo "Berhasil Ping dan Web server tidak berjalan!" >> log.log
#     kirim_email

else
#tidak bisa ping dan nginx
    echo "$down"
#mengirim pesan melalui bot telegram
    curl -s -X POST $url -d chat_id=$id_chat -d text="$down" > /dev/null 2>&1
#mengirim pesan melalui email
    sed -i "s/isi_pesan/$down/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    echo "Server tidak berjalan!" >> log.log
    query="INSERT INTO server_log VALUES(NULL,'$down','{formatted_time}')"
    sed -i "s/isi_pesan/$query/" $db
    insert_db
    kirim_email

fi


#cek exit code dari ping dan status web server
echo "bool ping = $bool_ping"
echo "bool nginx = $bool_nginx"
echo selesai
