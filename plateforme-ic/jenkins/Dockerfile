FROM jenkins/jenkins
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

USER root

RUN apt-get update
RUN apt-get -qq install docker

RUN curl -O "https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.gz"
RUN tar -xvjf "node-v8.9.4-linux-x64.tar.gz" -C /usr/local --strip-components=1 --no-same-owner
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN apt-get -qq install xvfb
RUN /usr/bin/Xvfb &

ADD ./id_rsa /var/jenkins_home/.ssh/
ADD ./id_rsa.pub /var/jenkins_home/.ssh/

RUN git config --global user.name "Jenkins"
RUN git config --global user.email "jenkins@apave.com"

USER jenkins
