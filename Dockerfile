FROM debian:buster

RUN apt-get update

RUN apt-get upgrade -y

RUN apt-get -y install wget

RUN apt-get -y install nginx

COPY index.html /var/www/html/

EXPOSE 80

CMD ["nginx","-g","daemon off;"]