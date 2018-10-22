FROM amazonlinux:latest

MAINTAINER sudhay

RUN mkdir app

COPY /installer.sh /installer.sh 

RUN chmod +x installer.sh

RUN ./installer.sh

RUN yum -y install zip
