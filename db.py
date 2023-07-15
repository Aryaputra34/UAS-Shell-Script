import mysql.connector
import os
from datetime import datetime

host = os.environ['HOST_DATABASE']
user = os.environ['USER_DATABASE']
password = os.environ['PASSWORD_DATABASE']
db = os.environ['NAMA_DATABASE']

def getMysqlConnection():
    return mysql.connector.connect(host=host, user=user, password=password, database=db)

curr_time = datetime.now()
formatted_time = curr_time.strftime('%Y-%m-%d %H:%M:%S')

db = getMysqlConnection()
cur = db.cursor()
query = f"INSERT INTO server_log VALUES(NULL,'Server berjalan dengan baik dan benar','{formatted_time}')"
cur.execute(query)
db.commit()
