# UAS-Shell-Script

langkah - langkah Penggunaan :
1. Setting email dengan cara menambah USERNAME_EMAIL="{email@email.com}" dan PASSWORD_EMAIL="{password_anda}" pada /etc/environment
2. Atau bisa dilakukan dengan menjalankan file sh setting_email.sh untuk menkonfigurasi nya secara otomatis
3. Jalankan sh cek-server.sh
4. buka contab dengan memasukkan crontab -e
5. tambahkan */5 * * * * /bin/bash PATH/cek-server.sh pada crontab untuk menjalankan kodenya setiap 5 menit
