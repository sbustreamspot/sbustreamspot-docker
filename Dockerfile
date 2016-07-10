FROM phusion/baseimage:0.9.19
MAINTAINER Emaad Ahmed Manzoor <emanzoor@cs.stonybrook.edu>

# Require git.tc.bbn.com credentials to build
ARG BBN_USER
ARG BBN_PASS

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Packages
RUN apt-get update && apt-get install -y python python2.7 python-pip python-dev \
                                         build-essential gcc git
RUN pip install --upgrade pip
RUN pip install numpy scipy scikit-learn

# ta3 Python bindings
RUN git clone https://$BBN_USER:$BBN_PASS@git.tc.bbn.com/bbn/ta3-api-bindings-python.git
RUN cd ta3-api-bindings-python; python setup.py install

# Build StreamSpot Core
ARG test
RUN git clone https://github.com/sbustreamspot/sbustreamspot-core.git -b 2016.07-engagement
RUN pip install -r sbustreamspot-core/requirements.txt
RUN cd sbustreamspot-core; make optimized

## Test StreamSpot Core
ADD test-streamspot-core.sh test-streamspot-core.sh
RUN chmod +x test-streamspot-core.sh
RUN ./test-streamspot-core.sh

# Build StreamSpot CDM
ARG test2
RUN git clone https://github.com/sbustreamspot/sbustreamspot-cdm.git
RUN pip install -r sbustreamspot-cdm/requirements.txt

## Test StreamSpot CDM
ADD test-streamspot-cdm.sh test-streamspot-cdm.sh
RUN chmod +x test-streamspot-cdm.sh
RUN ./test-streamspot-cdm.sh

# Build StreamSpot Train
RUN git clone https://github.com/sbustreamspot/sbustreamspot-train.git
RUN cd sbustreamspot-train/graphs-to-shingle-vectors; make optimized

## Test StreamSpot Train
ADD test-streamspot-train.sh test-streamspot-train.sh
RUN chmod +x test-streamspot-train.sh
RUN ./test-streamspot-train.sh
ADD test-streamspot-shingles.sh test-streamspot-shingles.sh
RUN chmod +x test-streamspot-shingles.sh
RUN ./test-streamspot-shingles.sh
ADD test-streamspot-clustering.sh test-streamspot-clustering.sh
RUN chmod +x test-streamspot-clustering.sh
RUN ./test-streamspot-clustering.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
