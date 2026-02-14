FROM ubuntu:22.04

ARG UTILS_USER_GID=1000
ARG UTILS_USER_UID=1000

ENV NMAP_UNPRIVILEGED=true

# Install prerequsites for installing stuff
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    software-properties-common \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Install tooling and architecture-specific dependencies.
RUN set -eux; \
    arch="$(dpkg --print-architecture)"; \
    if [ "$arch" = "amd64" ]; then \
      curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc >/dev/null; \
      add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/prod.list)"; \
      sqlcmd_pkg="sqlcmd"; \
    else \
      sqlcmd_pkg=""; \
      echo "Skipping sqlcmd install on unsupported architecture: $arch"; \
    fi; \
    apt-get update; \
    apt-get install -y \
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
      tcpdump \
      sshpass \
      telnet \
      $sqlcmd_pkg \
    ; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*


# # Unprivileged user setup
# RUN groupadd --gid ${UTILS_USER_GID} utils \
#   && useradd --uid ${UTILS_USER_UID} --gid ${UTILS_USER_GID} \
#     --shell /bin/bash --create-home utils
# USER utils
# WORKDIR /home/utils
