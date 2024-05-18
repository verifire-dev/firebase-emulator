# Stage 1: Build stage
FROM node:22-bullseye-slim AS build

WORKDIR /app
COPY . /app

# Install dependencies and build the project
RUN apt-get update -y && \
    apt-get install -y openjdk-17-jdk bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g firebase-tools && \
    npm --prefix /app/functions ci

# Stage 2: Final stage
FROM node:22-bullseye-slim

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Ensure the entrypoint script is in place and executable
RUN echo '#!/bin/sh \n firebase emulators:start' > /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]