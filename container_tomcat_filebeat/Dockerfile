FROM tomcat:8.5.12
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD context.xml /usr/local/tomcat/conf
ADD server.xml /usr/local/tomcat/conf

ADD manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml


RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.3.0-amd64.deb
RUN dpkg -i filebeat-5.3.0-amd64.deb

ADD filebeat.yml /etc/filebeat

CMD ["catalina.sh", "run"]