FROM ubuntu:14.04
MAINTAINER Jarret Raim <jarret@raim.io>

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

RUN apt-get -qq update &&\
    apt-get -qqy --force-yes dist-upgrade

RUN apt-get install -qqy python-software-properties software-properties-common

RUN add-apt-repository ppa:jcfp/ppa

RUN apt-get -qq update

RUN apt-get install -qqy --force-yes sabnzbdplus sabnzbdplus-theme-mobile \
sabnzbdplus-theme-smpl sabnzbdplus-theme-plush sabnzbdplus-theme-iphone \
par2 python-yenc unzip unrar

RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

VOLUME /mnt/config
VOLUME /mnt/local
VOLUME /mnt/nas

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8080

CMD ['sabnzbdplus --config-file "/mnt/config/sabnzbd.ini" --server :8080']

