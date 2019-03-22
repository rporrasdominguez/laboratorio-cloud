#Using image Ubuntu 18.04
FROM ubuntu:18.04

#Set the working directory to /app
WORKDIR /opt/app

#Copy all content
COPY . .

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# Install Node.js
RUN apt-get install --yes curl
RUN curl --silent --location https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install --yes nodejs
RUN apt-get install --yes build-essential

RUN npm install --only=production

# Binds to port 8888
EXPOSE 8888

CMD ["npm", "start"]
