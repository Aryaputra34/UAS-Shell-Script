input="172"
proxy="/etc/nginx/sites-available/reverse-proxy.conf"

cp template_reverse_proxy.conf $proxy

sed -i "s/127/$input/" $proxy

service nginx restart
cat $proxy
service nginx status
