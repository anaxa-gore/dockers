FROM redmine:latest

RUN apt-get update
RUN apt-get -qq install unzip

ADD circle_theme-2_1_2.zip /usr/src/redmine/public/themes
RUN unzip /usr/src/redmine/public/themes/circle_theme-2_1_2.zip -d /usr/src/redmine/public/themes

# Installation du plugin Agile (light)
ADD redmine_agile-1_4_4-pro.zip /usr/src/redmine/plugins
RUN unzip /usr/src/redmine/plugins/redmine_agile-1_4_4-pro.zip -d /usr/src/redmine/plugins
RUN bundle install --without development test

# Installation du plugin de notification Rocket.Chat
RUN git clone git://github.com/alphanodes/redmine_messenger.git plugins/redmine_messenger

# Install du plugin GitLab pour mise à jour temps réel du repository
RUN git clone git://github.com/phlegx/redmine_gitlab_hook.git plugins/gitlab

RUN mkdir /home/repositories