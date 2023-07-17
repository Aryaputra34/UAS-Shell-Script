#!/bin/bash

konfigurasi()
{
    echo ""
    echo "Konfigurasi Variabel Environment Database"
    read -p "Masukkan Host MySQL         : " host_db
    read -p "Masukkan User MySQL         : " user_db
    read -p "Masukkan Password MySQL     : " pass
    read -p "Masukkan Database baru      : " database

    cat note.txt | grep DATABASE >> /dev/null
    bool=$?

    if [ $bool -eq 0 ];then
        sed -i '/DATABASE/d' note.txt
    fi

    cat >> note.txt << EOF
HOST_DATABASE = $host_db
USER_DATABASE = $user_db
PASSWORD_DATABASE = $pass
NAMA_DATABASE = $database
EOF

     ./create_db.sh
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
