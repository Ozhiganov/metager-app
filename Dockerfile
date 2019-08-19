FROM nginx

RUN apt install nodejs
RUN npm install -g cordova
COPY . /app
WORKDIR /app
RUN cordova build browser --release
CMD cp platforms/browser/www/* /usr/share/nginx/html

EXPOSE 8000