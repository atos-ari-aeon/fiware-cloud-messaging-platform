#
# MongoDB Dockerfile
#

FROM ubuntu:latest

MAINTAINER Javier García. AEON development team

RUN \
   apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
   echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list && \
   apt-get update && \
   apt-get install -y mongodb-org

VOLUME ["/data/db"]
WORKDIR /data

EXPOSE 27017
EXPOSE 28017

CMD ["mongod"]
