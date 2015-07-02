# Project: Help.DaoCloud.IO
FROM nginx
MAINTAINER Vince Zhao <vince.zhao@daocloud.io>

# Specify versions
ENV NODE_VERSION        0.10.33
ENV GITBOOK_VERSION     2.1.0

# Install git for npm
RUN echo 'deb http://mirrors.163.com/debian jessie main' > /etc/apt/sources.list \
        && apt-get update \
        && apt-get install -y git-core \
        && rm -rf /var/lib/apt/lists/*

# Prepare build environment
ADD http://npm.taobao.org/mirrors/node/v0.10.33/node-v0.10.33-linux-x64.tar.gz /tmp/
RUN tar -xf /tmp/node-*.tar.gz -C /usr/local --strip-components=1\
        && npm --registry=http://registry.npm.taobao.org -g install gitbook-cli \
        && mkdir -p ~/.gitbook/versions/ \
        && npm --registry=http://registry.npm.taobao.org install gitbook@$GITBOOK_VERSION \
        && mv node_modules/gitbook ~/.gitbook/versions/$GITBOOK_VERSION \
        && rm -rf node_modules

# Load source
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# Build and Delivery
RUN ./build.sh \
        && rm -rf /usr/share/nginx/html/ \
        && mv /usr/src/app/dist /usr/share/nginx/html/

EXPOSE 80
