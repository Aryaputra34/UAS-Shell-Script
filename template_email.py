import smtplib
import os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
 
# Pengaturan email pengirim
email_pengirim = os.environ['USERNAME_EMAIL']
password = os.environ['PASSWORD_EMAIL']

# Pengaturan email penerima
email_penerima = "aryaputramaheswara34@gmail.com"

# Membuat objek MIMEMultipart
msg = MIMEMultipart()
msg['From'] = email_pengirim
msg['To'] = email_penerima
msg['Subject'] = "isi_subjek"

# Menambahkan isi email
pesan = "isi_pesan"
msg.attach(MIMEText(pesan, 'plain'))

# Mengirim email menggunakan server Gmail
try:
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(email_pengirim, password)
    server.send_message(msg)
    server.quit()
    print("Email berhasil dikirim")
except Exception as e:
    print("Terjadi kesalahan saat mengirim email:", str(e))
