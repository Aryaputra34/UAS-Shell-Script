import mysql.connector
from datetime import datetime

def getMysqlConnection():
    return mysql.connector.connect(host="127.0.0.1", user="root", password="", database="server")

curr_time = datetime.now()
formatted_time = curr_time.strftime('%Y-%m-%d %H:%M:%S')
print(formatted_time)

db = getMysqlConnection()
cur = db.cursor()
query = f"INSERT INTO server_log VALUES(NULL,'Server berjalan dengan baik dan benar','{formatted_time}')"
cur.execute(query)
db.commit()
