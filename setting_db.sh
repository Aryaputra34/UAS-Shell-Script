#!/bin/bash

konfigurasi()
{   
    echo ""
    echo "Konfigurasi Variabel Environment Database"
    read -p "host     : " host_db
    read -p "user     : " user_db
    read -p "password : " pass_db
    read -p "database : " database

    cat note.txt | grep DATABASE >> /dev/null
    bool=$?

    if [ $bool -eq 0 ];then
        sed -i '/DATABASE/d' note.txt
        echo variable lama telah dihapus
    fi

    cat >> note.txt << EOF
HOST_DATABASE = $host_db
USER_DATABASE = $user_db
PASSWORD_DATABASE = $pass_db
NAMA_DATABASE = $database
EOF

    sudo ./create_db.sh
}

mysql -V > /dev/null 2>&1

if [ $? -eq 0 ]; then
    konfigurasi
    
else
    echo ""
    echo "MySQL belum terinstall pada sistem operasi"
    echo "Melakukan instalasi MySQL"
    sudo apt-get install mysql-server -y
    echo ""
    echo "Instalasi Selesai!"

    echo ""
    konfigurasi
fi