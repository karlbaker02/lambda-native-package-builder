FROM package_builder_base:latest

MAINTAINER sudhay

RUN mkdir package

COPY /requirements.txt package/requirements.txt

WORKDIR /package

RUN pip3 install -r requirements.txt -t .

RUN zip -r deployment_package.zip . -x "requirements.txt"