FROM owncloudci/nodejs:latest

RUN npm install -g cordova
RUN cordova prepare
CMD cordova run browser