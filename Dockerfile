FROM owncloudci/nodejs:latest

RUN npm install -g cordova
COPY . /app
WORKDIR app
RUN sleep 5m
RUN cordova prepare
CMD cordova run browser

EXPOSE 8000