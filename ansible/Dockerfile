#FROM ansible/ubuntu14.04-ansible:stable
FROM ubuntu:14.04

ENV REFRESHED_AT 2015-07-26-15-26

RUN apt-get -y update && \
	apt-get install -y git build-essential python-pip aptitude
RUN pip install ansible ansible-lint
RUN git clone --depth 1 https://github.com/nickjj/rolespec && cd rolespec && sudo make install

#ADD wrapdocker /usr/local/bin/

VOLUME ["/ansible"]
VOLUME ["/var/lib/docker"]

WORKDIR  /ansible

#CMD ["/usr/local/bin/wrapdocker"]
