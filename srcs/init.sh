service nginx start
service mysql start

# Replace nginx default conf by mine
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
mv nginx_conf ./etc/nginx/sites-available 
ln -s /etc/nginx/sites-available/nginx_conf /etc/nginx/sites-enabled/nginx_conf

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password        
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password

# Get phpmyadmin & MySQL
mkdir /var/www/html/
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
mv phpMyAdmin-5.0.1-english phpmyadmin

service php7.3-fpm start
bash