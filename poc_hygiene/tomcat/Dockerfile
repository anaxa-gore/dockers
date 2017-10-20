FROM tomcat:latest
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

# Configuration de Tomcat
#ADD tomcat-users.xml /usr/local/tomcat/conf/
#ADD context.xml /usr/local/tomcat/conf
#ADD server.xml /usr/local/tomcat/conf
#ADD manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

ENV PATH /usr/local/tomcat/bin:${PATH}

RUN echo ${PATH}
RUN echo ${CATALINA_HOME}

CMD ["catalina.sh", "run"]
#CMD ["bash", "-c", "catalina.sh run"] 