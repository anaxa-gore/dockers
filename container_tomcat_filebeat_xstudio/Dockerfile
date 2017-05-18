FROM tomcat:8.5.12
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

# Configuration de Tomcat
ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD context.xml /usr/local/tomcat/conf
ADD server.xml /usr/local/tomcat/conf

ADD manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

# Installation de XStudio
RUN wget http://xstudio.alwaysdata.net/support/releases/3.1sp3/xstudio_v3_1sp3_web_package.zip -O /usr/local/tomcat/webapps/xstudio.zip
RUN unzip /usr/local/tomcat/webapps/xstudio.zip -d /usr/local/tomcat/webapps/xqual/
RUN rm /usr/local/tomcat/webapps/xstudio.zip

ADD xqual_config/xagent.jnlp /usr/local/tomcat/webapps/xqual/xstudio/
ADD xqual_config/xstudio.jnlp /usr/local/tomcat/webapps/xqual/xstudio/
ADD xqual_config/xstudio.jsp /usr/local/tomcat/webapps/xqual/xstudio/

ADD xqual_config/bugtracking.conf /usr/local/tomcat/webapps/xqual/xstudio/
ADD xqual_config/requirement.conf /usr/local/tomcat/webapps/xqual/xstudio/
ADD xqual_config/xstudio.conf /usr/local/tomcat/webapps/xqual/xstudio/
ADD xqual_config/plugin.conf /usr/local/tomcat/webapps/xqual/xstudio/

RUN cp /var/lib/tomcat7/webapps/xqual/xstudio/*.conf /var/lib/tomcat7/webapps/xqual/
RUN cp -r /var/lib/tomcat7/webapps/xqual/xstudio/jdbc/*/*.jar /var/lib/tomcat7/webapps/xqual/WEB-INF/lib/
ADD xqual_config/xstudio_web.conf /var/lib/tomcat7/webapps/xqual/xstudio.conf

# Installation & configuration des beats
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.3.0-amd64.deb
RUN dpkg -i filebeat-5.3.0-amd64.deb

ADD filebeat.yml /etc/filebeat

# On lance filebeat et Tomcat
CMD ["bash", "-c", "/etc/init.d/filebeat start && catalina.sh run"] 
