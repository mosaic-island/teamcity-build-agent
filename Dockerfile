FROM jetbrains/teamcity-agent:latest

USER root

ENV DOCKER_COMPOSE_VERSION="2.16.0"

# Install build & util tools.
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
       apt-utils wget python python2.7-dev fakeroot ca-certificates tar gzip zip \
       autoconf automake bzip2 file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev \
       libdb-dev libevent-dev libffi-dev libgeoip-dev libglib2.0-dev libjpeg-dev libkrb5-dev \
       liblzma-dev libmagickcore-dev libmagickwand-dev libmysqlclient-dev libncurses-dev libpng-dev \
       libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev \
       libyaml-dev make patch xz-utils zlib1g-dev unzip curl wget

# Install Chrome(HeadlessChrome) for Selenium Test
# From: https://gist.github.com/ziadoz/3e8ab7e944d02fe872c3454d17af31a5
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get -y update \
    && apt-get -y install google-chrome-stable

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) > /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose

# Instal AWS CLI & ecs-deploy (https://github.com/fabfuel/ecs-deploy)
RUN wget "https://bootstrap.pypa.io/pip/2.7/get-pip.py" -O /tmp/get-pip.py \
    && python /tmp/get-pip.py \
    && pip install awscli --upgrade \
    && pip install ecs-deploy

# Install Zulu 17
RUN wget -O /tmp/zulu17.tar.gz https://cdn.azul.com/zulu/bin/zulu17.40.19-ca-jdk17.0.6-linux_x64.tar.gz
RUN cd /opt/java/ && tar -zxvf /tmp/zulu17.tar.gz && ln -s zulu17.40.19-ca-jdk17.0.6-linux_x64 zulu-17

ENV JDK_17_0_x64 /opt/java/zulu-17

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean