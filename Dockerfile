FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install vim
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

COPY index.html /var/www/html/
COPY ./srcs/init.sh /
COPY ./srcs/nginx_conf /

EXPOSE 80

CMD bash init.sh