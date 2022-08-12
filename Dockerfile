FROM ubuntu:22.04

ARG UTILS_USER_GID=1000
ARG UTILS_USER_UID=1000

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    snmp \
    dnsutils \
    iputils-ping \
    net-tools \
    vim \
    jq \
    bind9-host \
    mtr-tiny \
    openssh-client \
    python3 \
    tmux \
&& apt-get clean && rm -rf /var/lib/apt/lists/*


# # Unprivileged user setup
# RUN groupadd --gid ${UTILS_USER_GID} utils \
#   && useradd --uid ${UTILS_USER_UID} --gid ${UTILS_USER_GID} \
#     --shell /bin/bash --create-home utils
# USER utils
# WORKDIR /home/utils
