FROM httpd:alpine
MAINTAINER Thomas Bonavia

# On ajoute un utilisateur fictif pour les tests
RUN touch /usr/local/apache2/conf/pwd
RUN htpasswd -b /usr/local/apache2/conf/pwd A4 @Soleil1

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

