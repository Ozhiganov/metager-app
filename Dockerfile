FROM nginx

RUN apt-get update && apt-get install npm -y
RUN npm install -g cordova
COPY . /app
WORKDIR /app
RUN cordova prepare
RUN cordova build browser --release
RUN rm /usr/share/nginx/html/* && cp -r platforms/browser/www/* /usr/share/nginx/html && chmod 755 -R /usr/share/nginx/html

EXPOSE 80