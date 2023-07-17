# UAS-Shell-Script

langkah - langkah Penggunaan :
1. Konfigurasi email pengirim notifikasi, pada /etc/environment tambahkan USERNAME_EMAIL="{email@email.com}" dan PASSWORD_EMAIL="{password_anda}" pada baris paling bawah
2. Atau bisa dilakukan dengan menjalankan file sh setting_email.sh untuk menkonfigurasi nya secara otomatis
3. Konfigurasi email penerima notifikasi, pada file cek-server.sh ganti isi dari email_penerima="" dengan email yang diinginkan
5. Jalankan sh cek-server.sh, untuk mengecek konfigurasi
6. buka contab dengan memasukkan sudo crontab -e, jika tidak sudo maka tidak bisa melihat status nginx
7. tambahkan */5 * * * * /bin/bash PATH/cek-server.sh pada crontab untuk menjalankan kodenya setiap 5 menit
