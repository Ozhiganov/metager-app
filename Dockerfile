FROM nodejscn/node:latest

RUN npm install -g cordova
RUN cordova prepare
CMD cordova run browser