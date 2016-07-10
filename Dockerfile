FROM phusion/baseimage:0.9.19
MAINTAINER Emaad Ahmed Manzoor <emanzoor@cs.stonybrook.edu>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# StreamSpot build instructions
ADD build-streamspot.sh /
RUN chmod +x build-streamspot.sh
RUN build-streamspot.sh 

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
