# Visit https://github.com/phusion/baseimage-docker/
# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:bionic-1.0.0
MAINTAINER @rigobertocanseco
ENV REFRESED_AT 2021-01-26
RUN echo /root /etc/container_environment/HOME

# Use baseimage-docker's init system.
CMD ["sbin/my_init"]

# ...put your own build instructions here...

# Set te locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set versions
# ENV ERLANG_VERSION=1:23.0
# ENV ELIXIR_VERSION=1.11.2

WORKDIR /tmp

# See https://github.com/phusion/baseimage-docker/issues/58
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Get prerequisites
RUN apt-get update && apt-get install -y git make unzip wget

# Set up Erlang
RUN wget http://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
RUN apt-get install ./erlang-solutions_2.0_all.deb -y
RUN apt-get update && apt-get install esl-erlang -y && apt-get install elixir -y && apt-get clean
RUN rm -rf /var/lib/apt/list/* /tmp/* /var/tmp/*

WORKDIR /
