FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for C++ build, MySQL client, zip/unzip, and git
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    make \
    git \
    wget \
    unzip \
    mysql-client \
    zip \
    systemd \
    libfmt-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Configure default MySQL credentials for siteupdate.sh
COPY my.cnf /root/.my.cnf
RUN chmod 600 /root/.my.cnf

# Copy ingestion runner script
COPY run-updates.sh /app/run-updates.sh
RUN chmod +x /app/run-updates.sh

ENTRYPOINT ["/app/run-updates.sh"]
