FROM tomcat:8.5.12
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

# Configuration de Tomcat
ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD context.xml /usr/local/tomcat/conf
ADD server.xml /usr/local/tomcat/conf
ADD manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml