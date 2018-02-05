FROM jenkins/jenkins
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

USER root

RUN apt-get update
RUN apt-get -qq install docker

RUN apt-get -qq install apt-utils
RUN apt-get -qq install nodejs

RUN apt-get -qq install xvfb
RUN /usr/bin/Xvfb &

ADD ./id_rsa /var/jenkins_home/.ssh/
ADD ./id_rsa.pub /var/jenkins_home/.ssh/

RUN git config --global user.name "Jenkins"
RUN git config --global user.email "jenkins@apave.com"

USER jenkins
