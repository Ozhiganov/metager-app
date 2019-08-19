FROM debian:stable

RUN apt-get update && apt-get install nginx npm -y
RUN npm install -g cordova
COPY . /app
WORKDIR /app
RUN cordova prepare
RUN cordova build browser --release
CMD rm /var/www/*
CMD cp platforms/browser/www/* /var/www

EXPOSE 80