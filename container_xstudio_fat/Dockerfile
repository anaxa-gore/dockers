FROM ubuntu:latest
MAINTAINER Thomas Bonavia <thomas.bonavia@apave.com>

RUN apt-get update
RUN apt-get install -qq unzip
RUN apt-get install -qq wget

# Installation de XStudio Fat Client pour XContinuousIntegration
RUN mkdir /tmp/xstudio
RUN wget http://xstudio.alwaysdata.net/support/releases/3.1sp7/xstudio_v3_1sp7_linux.tar.zip -O /tmp/xstudio/xstudio_v3_1sp7_linux.tar.zip
RUN unzip /tmp/xstudio/xstudio_v3_1sp7_linux.tar.zip -d /tmp/xstudio/
RUN tar -xvf /tmp/xstudio/xstudio_v3_1sp7_linux.tar -C /tmp/xstudio/

# Changement du mot de passe root
RUN echo "root:root" | chpasswd