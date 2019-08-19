FROM nginx

RUN apt-get update && apt-get install npm -y
RUN npm install -g cordova
COPY . /app
WORKDIR /app
RUN cordova prepare
RUN cordova build browser --release
RUN rm /var/www/* && cp platforms/browser/www/* /var/www

EXPOSE 80