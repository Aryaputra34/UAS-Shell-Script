curl -I 127.0.0.1:3000 | awk 'NR==1 {print $2}'

curl -I localhost | awk 'NR==1 {print $2}'

tail -n 1 /var/log/nginx/access.log | awk 'NR==1 {print $9}'
