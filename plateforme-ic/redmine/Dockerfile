FROM redmine:3.4.1

RUN apt-get update
RUN apt-get -qq install unzip 

ADD circle_theme-2_1_2.zip /usr/src/redmine/public/themes
RUN unzip /usr/src/redmine/public/themes/circle_theme-2_1_2.zip -d /usr/src/redmine/public/themes

# Installation du plugin Agile (light)
ADD redmine_agile-1_4_4-light.zip /usr/src/redmine/plugins
RUN unzip /usr/src/redmine/plugins/redmine_agile-1_4_4-light.zip -d /usr/src/redmine/plugins