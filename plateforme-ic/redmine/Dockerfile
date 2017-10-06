FROM redmine:latest

RUN apt-get update
RUN apt-get -qq install unzip

ADD circle_theme-2_1_2.zip /usr/src/redmine/public/themes
RUN unzip /usr/src/redmine/public/themes/circle_theme-2_1_2.zip -d /usr/src/redmine/public/themes

# Installation du plugin Tags (light)
ADD redmineup_tags-2_0_1-light.zip /usr/src/redmine/plugins
RUN unzip /usr/src/redmine/plugins/redmineup_tags-2_0_1-light.zip -d /usr/src/redmine/plugins
RUN bundle install --without development test

# Installation du plugin Agile
ADD redmine_agile-1_4_4-pro.zip /usr/src/redmine/plugins
RUN unzip /usr/src/redmine/plugins/redmine_agile-1_4_4-pro.zip -d /usr/src/redmine/plugins
RUN bundle install --without development test

# Installation du plugin de notification Rocket.Chat
RUN git clone git://github.com/alphanodes/redmine_messenger.git plugins/redmine_messenger

# Install du plugin GitLab pour mise à jour temps réel du repository
RUN git clone git://github.com/phlegx/redmine_gitlab_hook.git plugins/redmine_gitlab_hook

# Installation du plugin de synchronisation LDAP
RUN git clone https://github.com/thorin/redmine_ldap_sync.git plugins/redmine_ldap_sync

RUN mkdir /home/repositories