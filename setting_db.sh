#!/bin/bash
echo "Konfigurasi Database"
read -p "host     : " host_db
read -p "user     : " user_db
read -p "password : " pass_db
read -p "database : " database


cat /etc/environment | grep DATABASE >> /dev/null
bool=$?

delete(){
 sed -i '/DATABASE/d' /etc/environment
}

insert(){
    sed -i -e '$aexport HOST_DATABASE=\"'$host_db'\"' /etc/environment
    sed -i -e '$aexport USER_DATABASE=\"'$user_db'\"' /etc/environment
    sed -i -e '$aexport PASSWORD_DATABASE=\"'$pass_db'\"' /etc/environment
    sed -i -e '$aexport NAMA_DATABASE=\"'$database'\"' /etc/environment
}

if [ $bool -eq 0 ];then
    delete
    echo variable lama telah dihapus
fi

insert

echo ""
echo "--- Konfigurasi Database telah disimpan pada variabel environment"
echo "variable HOST_DATABASE     = $host_db"
echo "variable USER_DATABASE     = $user_db"
echo "variable PASSWORD_DATABASE = $pass_db"
echo "variable NAMA_DATABASE     = $database"