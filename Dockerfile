FROM ubuntu:18.04

ENV NODE_VERSION=v14.17.3
ENV NODE_DISTRO=linux-x64


RUN apt update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gettext-base \
    git \
    maven \
    python3-pip \
    software-properties-common \
    sudo \
    && \
    curl -o jdk-8u45-linux-x64.tar.gz http://ppq-java-8u45.s3-ap-southeast-2.amazonaws.com/jdk-8u45-linux-x64.tar.gz && \
    tar -C /usr/share -xzf jdk-8u45-linux-x64.tar.gz && \
    rm -rf jdk-8u45-linux-x64.tar.gz && \
    curl -o node.tar.xz https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz && \
    mkdir /usr/local/lib/nodejs && \
    tar -xJvf node.tar.xz -C /usr/local/lib/nodejs && \
    rm -rf node.tar.xz && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    pip3 install awscli && \
    curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest && \
    chmod +x /usr/local/bin/ecs-cli && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -    && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable" && \
    apt-get update && \
    apt-get install -y docker-ce yarn && \
    /usr/share/node-${NODE_VERSION}-${NODE_DISTRO}/bin/npm install -g grunt-cli bower webpack-cli && \
    apt clean && \
    useradd -ms /bin/bash ci && \
    echo "ci ALL = NOPASSWD : ALL" | tee /etc/sudoers.d/ci

USER ci
WORKDIR /home/ci

ENV NODEJS_HOME="/usr/local/lib/nodejs/node-${NODE_VERSION}-${NODE_DISTRO}/bin"
ENV JAVA_HOME="/usr/share/jdk1.8.0_45"
ENV PATH="${NODEJS_HOME}:${JAVA_HOME}/bin:${PATH}"
