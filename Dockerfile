FROM ubuntu:22.04

ARG UTILS_USER_GID=1000
ARG UTILS_USER_UID=1000

RUN apt-get update && apt-get install -y \
    curl \
    snmp \
    dnsutils \
    net-tools \
    vim \
    jq \
    bind9-host \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Locale setup
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Unprivileged user setup
RUN groupadd --gid ${UTILS_USER_GID} utils \
  && useradd --uid ${UTILS_USER_UID} --gid ${UTILS_USER_GID} \
    --shell /bin/bash --create-home utils
USER utils
WORKDIR /home/utils