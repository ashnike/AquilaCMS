# Use an official Ubuntu 20.04 base image
FROM ubuntu:20.04

# Set the working directory in the container
WORKDIR /src

# Expose the port your application will be running on
EXPOSE 3010

# Install dependencies, wkhtmltox, and curl
RUN apt-get update -y && \
    apt-get install -y wget fontconfig libjpeg-dev libssl-dev xfonts-75dpi xfonts-base libjpeg-turbo8 libssl1.1 libx11-6 libxcb1 libxext6 libxrender1 && \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb && \
    dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb && \
    apt install -f && \
    apt-get install -y gnupg curl mongodb-clients

# Install Node.js 16
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && \
    apt-get install yarn -y
# Copy your application code into the container
COPY . /src

# Install project dependencies using Yarn
RUN yarn install

# Clean up to reduce image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Download global-bundle.pem
RUN wget -O /src/global-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

# Define the command to start your application
CMD ["npm", "start"]
