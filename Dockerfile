# Jenkins LTS image
FROM jenkins/jenkins:lts-jdk21

# Temporarily use root only while installing required tools
USER root

# Install Docker CLI, Git, curl and required utilities
RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        git && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg \
        -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
        > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# Jenkins itself runs as the non-root Jenkins user
USER jenkins