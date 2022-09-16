# syntax=docker/dockerfile:1
#!/usr/bin/env bash
# docker login if needed `docker login docker.io`

FROM ubuntu

MAINTAINER nikhil2584@gmail.com

USER root

RUN mkdir /opt/tomcat/
RUN mkdir /opt/nodeexporter/
#WORKDIR /opt/tomcat/
#ENV WORKPATH /opt/tomcat/
#WORKDIR $WORKPATH

WORKDIR /opt/tomcat/
COPY ./apache-tomcat-8.5.82.tar.gz /opt/tomcat/
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.82/* /opt/tomcat/

WORKDIR /opt/nodeexporter/
COPY ./node_exporter-1.4.0-rc.0.linux-amd64.tar.gz /opt/nodeexporter/
RUN tar xvfz node_exporter-1.4.0-rc.0.linux-amd64.tar.gz
RUN mv node_exporter-1.4.0-rc.0.linux-amd64/* /opt/nodeexporter/
COPY ./install-node-exporter.sh /opt/nodeexporter/

RUN apt update
RUN apt install -y default-jdk
RUN java -version
COPY ./SampleWebApp.war /opt/tomcat/webapps/

ENV CATALINA_HOME /opt/tomcat/
ENV CATALINA_BASE /opt/tomcat/

ENV PATH $PATH:$CATALINA_HOME/bin:$CATALINA_HOME/lib

EXPOSE 8080
RUN chmod -R 777 /opt/tomcat/bin
#ENTRYPOINT ["/opt/tomcat/bin"]
#CMD ["catalina.sh" "-D", "FOREGROUND"]
CMD ["catalina.sh", "run"]
ENTRYPOINT ["/opt/nodeexporter/install-node-exporter.sh", "run"]


