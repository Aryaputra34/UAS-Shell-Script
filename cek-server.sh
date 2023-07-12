#untuk cek apakah website pnj down atau tidak
#kalo /dev/null aja error nya bakal muncul ke terminal. Pake 2>&1 untuk silence semua output
ping elearning.pnj.ac.id -c 1 > /dev/null 2>&1

#masukkan hasil exit code ke variabel bool_ping
bool_ping=$?

#untuk cek apakah nginx nya running atau tidak
sudo systemctl status nginx | grep "Active: active" > /dev/null 2>&1

#masukkan hasil exit code ke variabel bool_nginx
bool_nginx=$?

#variabel isi pesan ataupun subjek
sukses="berhasil ping dan nginx"
nginx="berhasil nginx gagal ping"
ping="berhasil ping gagal nginx"
down="server mati, tidak bisa ping ke website dan web server down"
subjek="Monitoring Server TIK PNJ"

#path
email="/home/arya/shell_uas/email1.py"
template="/home/arya/shell_uas/template_email.py"

#copy isi template email
cp template_email.py email1.py

kirim_email()
{
 python3 $email
}

#bisa ping dan nginx
if [ $bool_ping -eq 0 ] && [ $bool_nginx -eq 0 ];then

    echo $suskses
    sed -i "s/isi_pesan/$sukses/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    kirim_email

#hanya nginx
elif [ $bool_nginx -eq 0 ];then

    echo berhasil nginx gagal ping
    sed -i "s/isi_pesan/$nginx/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    kirim_email

#hanya ping
elif [ $bool_ping -eq 0 ];then

    echo berhasil ping gagal nginx
    sed -i "s/isi_pesan/$ping/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    kirim_email

else
#tidak bisa ping dan nginx
    echo server mati
    sed -i "s/isi_pesan/$down/" $email
    sed -i "s/isi_subjek/$subjek/" $email
    kirim_email

fi


#cek exit code dari ping dan status web server
echo "bool ping = $bool_ping"
echo "bool nginx = $bool_nginx"
echo selesai
