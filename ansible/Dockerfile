#FROM ansible/ubuntu14.04-ansible:stable
FROM ubuntu:14.04

RUN apt-get -y update && \
	apt-get install -y git build-essential python-pip aptitude
RUN pip install ansible ansible-lint
RUN git clone --depth 1 https://github.com/nickjj/rolespec && cd rolespec && sudo make install

VOLUME [/ansible]

WORKDIR /ansible
