import smtplib
import os
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders
from docx1 import file_path_pdf
 
# Pengaturan email pengirim
email_pengirim = os.environ['USERNAME_EMAIL']
password = os.environ['PASSWORD_EMAIL']

# Pengaturan email penerima
email_penerima = os.environ['PENERIMA_EMAIL']

# Membuat objek MIMEMultipart
msg = MIMEMultipart()
msg['From'] = email_pengirim
msg['To'] = email_penerima
msg['Subject'] = "isi_subjek"

# Menambahkan isi email
pesan = "isi_pesan"
msg.attach(MIMEText(pesan, 'plain'))

nama_file = file_path_pdf
with open(nama_file, "rb") as attachment:
    part = MIMEBase("application", "octet-stream")
    part.set_payload(attachment.read())

encoders.encode_base64(part)
part.add_header(
    "Content-Disposition",
    f"attachment; filename= {nama_file}",
)
msg.attach(part)

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


os.remove(file_path_pdf)
