FROM debian:stable

RUN apt install nginx nodejs
RUN npm install -g cordova
COPY . /app
WORKDIR /app
RUN cordova build browser --release
CMD rm /var/www/*
CMD cp platforms/browser/www/* /var/www

EXPOSE 80