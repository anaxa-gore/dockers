FROM httpd:latest
MAINTAINER Thomas Bonavia

# On ajoute un utilisateur fictif pour les tests
RUN touch /usr/local/apache2/conf/pwd
RUN htpasswd -b /usr/local/apache2/conf/pwd A4 @Soleil1

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

COPY ./libapache2-mod-auth-openidc_2.3.1-1.jessie.1_amd64.deb /tmp/openidc.deb
RUN apt-get update
RUN apt-get install --assume-yes gdebi
RUN gdebi --q --n /tmp/openidc.deb