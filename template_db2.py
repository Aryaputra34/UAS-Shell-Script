import mysql.connector
import subprocess
from datetime import datetime

#Generate
host = subprocess.check_output("awk -F= '/HOST_DATABASE/ {print $2}' /home/arya/shell_uas/note.txt", shell=True).decode('utf-8').strip()
user = subprocess.check_output("awk -F= '/USER_DATABASE/ {print $2}' /home/arya/shell_uas/note.txt", shell=True).decode('utf-8').strip()
password = subprocess.check_output("awk -F= '/PASSWORD_DATABASE/ {print $2}' /home/arya/shell_uas/note.txt", shell=True).decode('utf-8').strip()
db2 = subprocess.check_output("awk -F= '/NAMA_DATABASE/ {print $2}' /home/arya/shell_uas/note.txt", shell=True).decode('utf-8').strip()

def getMysqlConnection():
    return mysql.connector.connect(host=host, user=user, password=password, database=db2)

curr_time = datetime.now()
formatted_time = curr_time.strftime('%Y-%m-%d %H:%M:%S')

db = getMysqlConnection()
cur = db.cursor()
query = f"isi_pesan"
cur.execute(query)
db.commit()
