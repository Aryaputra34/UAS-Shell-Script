#!/bin/bash
read -p "email : " username

echo  "password : "
stty -echo
read password
stty echo

#echo 'TEST_USERNAME_EMAIL="$username"' >> ~/.profile_tmp
#echo 'TEST_PASSWORD_EMAIL="$password"' >> ~/.profile_tmp

sed -i -e '$aexport USERNAME_EMAIL=\"'$username'\"' /etc/environment
sed -i -e '$aexport PASSWORD_EMAIL=\"'$password'\"' /etc/environment

echo $username $password
