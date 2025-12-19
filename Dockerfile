FROM ubuntu:22.04

ARG UTILS_USER_GID=1000
ARG UTILS_USER_UID=1000

ENV NMAP_UNPRIVILEGED=true

# Install prerequsites for installing stuff
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    ca-certificates \
    software-properties-common \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Create keyrings directory for package signing keys
RUN install -m 0755 -d /etc/apt/keyrings

# Microsoft Stuff
# Note: Using --no-check-certificate for CI environment with TLS MITM proxy
# The GPG signature verification provides security, not the HTTPS connection
RUN wget --no-check-certificate -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
RUN echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" | tee /etc/apt/sources.list.d/microsoft.list
# For:
# sqlcmd

# Google Cloud SDK
# Note: Using --no-check-certificate for CI environment with TLS MITM proxy
# The GPG signature verification provides security, not the HTTPS connection
RUN wget --no-check-certificate -O- https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Configure apt to skip SSL verification for CI environment with TLS MITM proxy
# Package integrity is still verified via GPG signatures
RUN echo 'Acquire::https::packages.microsoft.com::Verify-Peer "false";' > /etc/apt/apt.conf.d/99insecure-repos && \
    echo 'Acquire::https::packages.cloud.google.com::Verify-Peer "false";' >> /etc/apt/apt.conf.d/99insecure-repos

RUN apt-get update && apt-get install -y \
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
    sqlcmd \
    tcpdump \
    sshpass \
    telnet \
    google-cloud-cli \
&& apt-get clean && rm -rf /var/lib/apt/lists/*


# # Unprivileged user setup
# RUN groupadd --gid ${UTILS_USER_GID} utils \
#   && useradd --uid ${UTILS_USER_UID} --gid ${UTILS_USER_GID} \
#     --shell /bin/bash --create-home utils
# USER utils
# WORKDIR /home/utils
