service nginx start
service mysql start
service php7.3-fpm start

#Replace nginx default conf by mine
rm /etc/nginx/sites-available/default
mv nginx_conf ./etc/nginx/sites-available 