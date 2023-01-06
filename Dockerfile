# to use node19 alpine from dockerhub to use as a base image, build - short name for the command:
FROM node:19-alpine as build

# to create working directory:
WORKDIR /app

# to download CA content:
RUN wget https://github.com/A619-lex/cbwa_ca2/archive/main.tar.gz && tar xf main.tar.gz && rm main.tar.gz

WORKDIR /app/cbwa_ca2-main/

# to install ionic and its dependencies:
RUN npm install -g ionic
RUN npm install

# to copy everything from the root directory to app directory:
RUN npm run-script build --prod

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/cbwa_ca2-main/www /usr/share/nginx/html/


EXPOSE 80
