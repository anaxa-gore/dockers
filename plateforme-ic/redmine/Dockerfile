FROM redmine:3.4.1

USER root

RUN apt-get update
RUN apt-get -qq install unzip 

ADD circle_theme-2_1_2.zip /usr/src/redmine/public/themes
RUN unzip circle_theme-2_1_2.zip

USER redmine