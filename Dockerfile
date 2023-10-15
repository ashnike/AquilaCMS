FROM ubuntu:20.04
# Set the working directory in the container
WORKDIR /src
EXPOSE 3010

# Install dependencies and wkhtmltox
RUN apt-get update -y && apt-get install -y wget fontconfig libjpeg-dev libssl-dev xfonts-75dpi xfonts-base libjpeg-turbo8 libssl1.1 libx11-6 libxcb1 libxext6 libxrender1 && \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb && \
    dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb && \
    apt install -f && \
    apt-get install -y gnupg

# Install curl
RUN apt-get install -y curl
# Install Node.js 14 (or your desired version)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
# Install NVM and Node.js
#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
   # export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    #nvm install 18 && \
    #nvm use 18

# Install Yarn
RUN wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && apt-get install yarn -y

# Copy your application code into the container
COPY . /src

# Install project dependencies using Yarn
RUN yarn install

# Define the command to start your application
CMD ["npm", "start"]
