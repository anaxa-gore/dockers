FROM httpd:latest
MAINTAINER Thomas Bonavia

COPY httpd.conf /usr/local/apache2/conf/httpd.conf

RUN echo 172.29.96.211 proxy.rocket.com > /etc/hosts; cat /etc/hosts