# syntax=docker/dockerfile:1
#!/usr/bin/env bash
# docker login if needed `docker login docker.io`

FROM ubuntu

MAINTAINER nikhil2584@gmail.com

USER root

RUN mkdir /opt/tomcat/
#WORKDIR /opt/tomcat/
ENV WORKPATH /opt/tomcat/
WORKDIR $WORKPATH

COPY ./apache-tomcat-8.5.82.tar.gz /opt/tomcat/
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.82/* /opt/tomcat/
RUN apt update
RUN apt install -y default-jdk
RUN java -version
COPY ./SampleWebApp.war /opt/tomcat/webapps/

ENV CATALINA_HOME /opt/tomcat/
ENV CATALINA_BASE /opt/tomcat/

ENV PATH $PATH:$CATALINA_HOME/bin:$CATALINA_HOME/lib
#RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war
EXPOSE 8080
RUN chmod -R 777 /opt/tomcat/bin
#ENTRYPOINT ["/opt/tomcat/bin"]
#CMD ["catalina.sh" "-D", "FOREGROUND"]
CMD ["catalina.sh", "run"]

