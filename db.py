import mysql.connector
from datetime import datetime

def getMysqlConnection():
    return mysql.connector.connect(host="localhost", user="root", password="", database="server")

curr_time = datetime.now()
formatted_time = curr_time.strftime('%Y-%m-%d %H:%M:%S')
print(formatted_time)

db = getMysqlConnection()
cur = db.cursor()
query = f"INSERT INTO server_log VALUES(NULL,'berhasil ping dan nginx','{formatted_time}')"
cur.execute(query)
db.commit()