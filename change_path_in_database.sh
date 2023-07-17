sed -i "/host =/d" template_db.py
sed -i "/user =/d" template_db.py
sed -i "/password =/d" template_db.py
sed -i "/db2 =/d" template_db.py

var4="host = subprocess.check_output(\"awk -F= '/HOST_DATABASE/ {print \$2}' $PWD/note.txt\", shell=True).decode('utf-8').strip()"
var3="user = subprocess.check_output(\"awk -F= '/USER_DATABASE/ {print \$2}' $PWD/note.txt\", shell=True).decode('utf-8').strip()"
var2="password = subprocess.check_output(\"awk -F= '/PASSWORD_DATABASE/ {print \$2}' $PWD/note.txt\", shell=True).decode('utf-8').strip()"
var1="db2 = subprocess.check_output(\"awk -F= '/NAMA_DATABASE/ {print \$2}' $PWD/note.txt\", shell=True).decode('utf-8').strip()"

sed -i "/#Generate/a $var1" template_db.py
sed -i "/#Generate/a $var2" template_db.py
sed -i "/#Generate/a $var3" template_db.py
sed -i "/#Generate/a $var4" template_db.py

