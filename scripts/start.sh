#!/bin/bash

# Navigate to your application
cd /home/ubuntu/AquilaCMS
# Define the Docker image name
image_name="auxila"

# Check if a container with the same name exists
if [ "$(sudo docker ps -aq -f name=$image_name)" ]; then
    # Stop and remove the existing container
    sudo docker stop $image_name
    sudo docker rm $image_name
fi
sudo docker build -t auxila:latest .
sudo docker run -d -p 3010:3010 --name auxila --restart always auxila:latest

