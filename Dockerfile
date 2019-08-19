FROM nginx

RUN apk update && apk add --update npm
RUN npm install -g cordova
COPY . /app
WORKDIR /app
RUN cordova prepare
RUN cordova build browser --release
CMD rm /var/www/*
CMD cp platforms/browser/www/* /var/www

EXPOSE 80