FROM node:16.15.0-alpine3.15

RUN apk add --no-cache openjdk8-jre
RUN apk add --no-cache bash

RUN npm install -g firebase-tools@10.9.2

COPY run.sh .
COPY firebase.json .
COPY .firebaserc .

ENTRYPOINT ["./run.sh"]