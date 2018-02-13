FROM tomcat:8-alpine
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

# Configuration de Tomcat
ADD tomcat-users.xml /usr/local/tomcat/conf/
#ADD context.xml /usr/local/tomcat/conf
ADD server.xml /usr/local/tomcat/conf
ADD manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

RUN mkdir  /usr/local/tomcat/personal_conf
VOLUME ["/usr/local/tomcat/personal_conf"]