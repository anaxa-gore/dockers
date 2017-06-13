FROM jenkins:2.46.3
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

USER root
RUN apt-get update
RUN apt-get -qq install xvfb
RUN /usr/bin/Xvfb &
USER jenkins