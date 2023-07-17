#!/bin/bash
echo "Konfigurasi User Email Pengirim"
read -p "email : " username

echo  "password : "
stty -echo
read password
stty echo

echo "Konfigurasi User Email Penerima"
read -p "email penerima : " penerima

cat /etc/environment | grep EMAIL >> /dev/null
bool=$?

delete(){
 sed -i '/EMAIL/d' /etc/environment
}
insert(){
    sed -i -e '$aexport USERNAME_EMAIL=\"'$username'\"' /etc/environment
    sed -i -e '$aexport PASSWORD_EMAIL=\"'$password'\"' /etc/environment
    sed -i -e '$aexport PENERIMA_EMAIL=\"'$penerima'\"' /etc/environment
}

if [ $bool -eq 0 ];then
    delete
    echo variable lama telah dihapus
fi

insert

echo "--- Email pengirim dan penerima sudah disimpan pada variable environment"
echo "variable USERNAME_EMAIL = $username"
echo "variable PASSWORD_EMAIL = $password"
echo "variable PENERIMA_EMAIL = $penerima"