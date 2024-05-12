FROM node:22-bullseye-slim

WORKDIR /app
COPY . /app

RUN apt-get update -y && \
    apt-get install -y openjdk-17-jdk bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN npm install -g firebase-tools

RUN npm --prefix /app/functions ci

RUN echo '#!/bin/sh \n firebase emulators:start' > /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
