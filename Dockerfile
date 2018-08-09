FROM ubuntu:18.04
RUN apt update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    curl \
    gettext-base \
    git \
    maven \
    nodejs \
    openjdk-8-jdk \
    python3-pip \
    software-properties-common \
    && \
    \
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
    npm install -g grunt-cli bower webpack-cli
