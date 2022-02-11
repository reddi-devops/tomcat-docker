###  Docker file for Tomcat 9.5"
from centos:7
MAINTAINER "Reddi Kishore Kalle"
WORKDIR /opt/
ADD     https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58.zip  . 
RUN 	yum install wget unzip -y &&\
	rpm -ivh https://gitlab.com/reddi.devops/java8/-/raw/main/jdk-8u321-linux-x64.rpm  &&\
	unzip apache-tomcat-9.0.58 &&\
	chmod -R 775 apache-tomcat-9.0.58 &&\
	ln -sf "/usr/share/zoneinfo/Asia/Kolkata" /etc/localtime &&\
	rm -rf apache-tomcat-9.0.58.zip 
WORKDIR /opt/apache-tomcat-9.0.58/webapps/
ENV NODE_ROUTING_SUFFIX="_`hostname`_`hostname -I`"
ADD https://gitlab.com/reddi.devops/java8/-/raw/main/apps.zip .  
RUN unzip -o apps.zip
WORKDIR /opt/apache-tomcat-9.0.58/conf/
ADD https://gitlab.com/reddi.devops/java8/-/raw/main/server.xml .
ADD https://gitlab.com/reddi.devops/java8/-/raw/main/tomcat-users.xml .
EXPOSE 8080
WORKDIR /opt/apache-tomcat-9.0.58/bin/
ADD  https://gitlab.com/reddi.devops/java8/-/raw/main/setenv.sh .
RUN ls -ltr catalina.sh && chmod 777 catalina.sh
CMD ["./catalina.sh", "run"]
