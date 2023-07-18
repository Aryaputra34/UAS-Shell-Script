#!/bin/bash

while true; do
echo "Silahkan pilih opsi yang diinginkan."
echo "1. Tambah jadwal tugas baru"
echo "2. Lihat daftar jadwal tugas"
echo "3. Hapus jadwal tugas yang sudah ada"
echo "4. Exit"

read -p "Masukan opsi (1/2/3/4): " option
echo
case $option in
1)
	echo "Tambah jadwal tugas baru:"

	read -p "Masukan menit (0-59, atau * untuk setiap menit): " minute
	read -p "Masukan jam (0-23, atau * untuk setiap jam): " hour
	read -p "Masukan tanggal (1-31, atau * untuk setiap tanggal): " day
	read -p "Masukan bulan (1-12, atau * untuk setiap bulan): " month
	read -p "Masukan hari dalam seminggu (0-7, 0 dan 7 mewakili Minggu, atau * untuk setiap hari): " day_of_week
	read -p "Masukan perintah atau path file yang ingin dilankan: " command

	cron_entry="$minute $hour $day $month $day_of_week $command"
	(sudo crontab -l ; echo "$cron_entry") | sudo crontab -
	echo "Jadwal tugas berhasil ditambahkan"
	;;
2)
	echo "Daftar jadwal tugas:"
	sudo crontab -l | nl -w2 -s". "
	echo
	;;
3)
	echo "Hapus jadwal tugas yang sudah ada:"
	# Menampilkan daftar jadwal yang sudah ada
	 echo "Daftar jadwal tugas:"
	sudo crontab -l | nl -w2 -s". "
	echo
	read -p "Masukkan nomor baris jadwal yang ingin dihapus : " line_number

	 # Menghapus jadwal pada baris yang ditentukan
	sudo crontab -l | sed -e "${line_number}d" | sudo crontab -

	echo "Jadwal tugas berhasil dihapus!"
	;;
4)
	echo "Keluar dari program."
	exit 0
	;;
*)
	echo "Opsi tidak valid. Silakan pilih opsi 1, 2, 3, atau 4."
	;;
esac
done
