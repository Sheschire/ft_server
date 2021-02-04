service mysql start

# Replace nginx default conf by custom
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
mv nginx_conf ./etc/nginx/sites-available/42_ft_server
ln -s /etc/nginx/sites-available/42_ft_server /etc/nginx/sites-enabled/42_ft_server

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password        
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password

# Get phpmyadmin & MySQL
mkdir /var/www/42_ft_server/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
mv phpMyAdmin-5.0.1-english phpmyadmin

service php7.3-fpm start

# Replace php default conf by custom
rm ./phpmyadmin/config.sample.inc.php
cp config.sample.inc.php ./var/www/42_ft_server/
mv config.sample.inc.php ./phpmyadmin/

# Install wordpress
cd /var/www/42_ft_server
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
cd
mv 

service nginx start
bash