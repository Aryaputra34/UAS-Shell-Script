proxy="/etc/nginx/sites-available/reverse-proxy.conf"
cp template_reverse_proxy.conf $proxy
service nginx restart
cat $proxy
service nginx status
