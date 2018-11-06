#!/bin/bash

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce

#steps to allow running docker without sudo

sudo groupadd docker

echo "Adding $USER to docker group" 
sudo gpasswd -a ${USER} docker

echo "Restarting docker"
sudo service docker restart

echo "Changing user $USER to group docker" 
newgrp docker &
