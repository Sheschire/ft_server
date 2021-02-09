# Install wordpress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

# Replace wordpress default by custom
rm wordpress/wp-config-sample.php
mv wp-config-sample.php wordpress/

# Get phpmyadmin & MySQL
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
mv phpMyAdmin-5.0.1-english phpmyadmin

# Replace php default conf by custom
rm phpmyadmin/config.sample.inc.php
mv config.sample.inc.php phpmyadmin/
cd ../../../

# SSL
apt-get install openssl
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=root/CN=localhost"

# Authorization
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*


service nginx start
service php7.3-fpm start
service mysql start

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password        
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password

bash