FROM docker.elastic.co/logstash/logstash:5.3.0
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

#RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-json

ADD simple-pipeline.conf /usr/share/logstash/pipeline
ADD tomcat_with_duration.pattern /etc/logstash/patterns/tomcat_with_duration.pattern
ADD forum.pattern /etc/logstash/patterns/forum.pattern