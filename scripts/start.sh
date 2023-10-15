#!/bin/bash

# Navigate to your application
cd /home/ubuntu/AquilaCMS

# Define the Docker image name
image_name="auxila"

# Check if a container with the same name exists
if [ "$(sudo docker ps -aq -f name=$image_name)" ]; then
    # Stop and remove the existing container
    if sudo docker stop $image_name && sudo docker rm $image_name; then
        echo "Existing container $image_name stopped and removed."
    else
        echo "Failed to stop and remove the existing container $image_name."
        exit 1  # Exit with an error code
    fi
fi

# Build the Docker image
if sudo docker build -t $image_name:latest .; then
    echo "Docker image $image_name:latest built successfully."
else
    echo "Failed to build the Docker image $image_name:latest."
    exit 1  # Exit with an error code
fi

# Run the container
if sudo docker run -d -p 3010:3010 --name $image_name --restart always $image_name:latest; then
    echo "Container $image_name started successfully."
else
    echo "Failed to start container $image_name."
    exit 1  # Exit with an error code
fi
