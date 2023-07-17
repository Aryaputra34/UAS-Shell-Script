#!/bin/bash

#variabel
user=$(cat note.txt | awk -F= '/USER_DATABASE =/ {print $2}')
pass=$(cat note.txt | awk -F= '/PASSWORD_DATABASE =/ {print $2}')
host=$(cat note.txt | awk -F= '/HOST_DATABASE =/ {print $2}')
nama_db=$(cat note.txt | awk -F= '/NAMA_DATABASE =/ {print $2}')


# Nama tabel baru
read -p "Masukkan Nama Table Baru    : " NAMA_TABLE

echo""
echo "Akan dilakukan Pembuatan Database Baru dengan Nama $nama_db dan Tabel Baru $NAMA_TABLE"
echo "Akan dilakukan Pembuatan 3 Fields; id, pesan_log, dan waktu, dengan id sebagai primary key"
echo ""
read -p "Lanjutkan? Y/N: " lanjutkh
echo ""

if [ "$lanjutkh" == "Y" ] || [ "$lanjutkh" == "y" ]; then
    # Daftar field dan tipe datanya
    FIELDS=(
    "id int not null auto_increment"
    "pesan_log text not null"
    "waktu timestamp default current_timestamp on update current_timestamp"
    "primary key(id)"
    )

    # Perintah untuk membuat database
    CREATE_DATABASE_QUERY="CREATE DATABASE $nama_db;"

    # Perintah untuk membuat tabel
    CREATE_TABLE_QUERY="USE $nama_db; CREATE TABLE $NAMA_TABLE ("

    # Loop untuk menambahkan field ke perintah CREATE TABLE
    for field in "${FIELDS[@]}"
    do
    CREATE_TABLE_QUERY+=" $field,"
    done

    # Menghapus koma terakhir
    CREATE_TABLE_QUERY=${CREATE_TABLE_QUERY%,}

    CREATE_TABLE_QUERY+=" );"

    # Eksekusi perintah menggunakan mysql client
    sudo mysql -u $user -p -h $host -e "$CREATE_DATABASE_QUERY $CREATE_TABLE_QUERY"

    # Periksa apakah perintah berhasil atau tidak
    if [ $? -eq 0 ]; then
    echo ""
    echo "Database$nama_db berhasil dibuat."
    echo "Tabel $NAMA_TABLE berhasil dibuat dengan field-field berikut:"
    for field in "${FIELDS[@]}"
    do
        echo "- $field"
    done
    else
    echo "Gagal membuat database $nama_db atau tabel $NAMA_TABLE."
    fi

elif [ "$lanjutkh" == "N" ] || [ "$lanjutkh" == "n" ]; then
    echo "Thx"
    exit
else
    echo "Pilihan yang Anda masukkan salah!"
    exit
fi
