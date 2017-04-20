FROM tomcat:latest
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD context.xml /usr/local/tomcat/conf/

# RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.3.0-amd64.deb
# RUN dpkg -i filebeat-5.3.0-amd64.deb

CMD ["catalina.sh", "run"]