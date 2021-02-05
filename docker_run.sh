#!/bin/bash

docker system prune
docker build -t mycontainer .
docker run -it --rm -p 80:80 -p 443:443 mycontainer
