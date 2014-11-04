FROM ubuntu:trusty
MAINTAINER Jerzy Kozera <jerzy.kozera@gmail.com>

WORKDIR /root
USER root

ADD setup.sh /root/setup.sh
RUN /root/setup.sh
