FROM ubuntu:22.04

ARG UTILS_USER_GID=1000
ARG UTILS_USER_UID=1000

ENV NMAP_UNPRIVILEGED=true

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    snmp \
    snmp-mibs-downloader \
    dnsutils \
    iputils-ping \
    net-tools \
    vim \
    jq \
    bind9-host \
    mtr-tiny \
    openssh-client \
    postgresql-client \
    python3 \
    strace \
    tmux \
    nmap \
    openssh-client \
    htop \
    isc-dhcp-client \
&& apt-get clean && rm -rf /var/lib/apt/lists/*


# # Unprivileged user setup
# RUN groupadd --gid ${UTILS_USER_GID} utils \
#   && useradd --uid ${UTILS_USER_UID} --gid ${UTILS_USER_GID} \
#     --shell /bin/bash --create-home utils
# USER utils
# WORKDIR /home/utils
