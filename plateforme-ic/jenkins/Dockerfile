FROM jenkins/jenkins
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

USER root

RUN apt-get update
RUN apt-get -qq install docker

RUN apt-get -qq install xvfb
RUN /usr/bin/Xvfb &

RUN git config --global user.name Jenkins
RUN git config --global user.email jenkins@apave.com

USER jenkins