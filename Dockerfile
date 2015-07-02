# Project: Help.DaoCloud.IO

FROM nginx
MAINTAINER Vince Zhao <vince.zhao@daocloud.io>

# Specify versions
ENV NODE_VERSION	0.10.33
ENV GITBOOK_VERSION	2.1.0

# Install git
RUN apt-get update \
	&& apt-get install -y git-core \
	&& rm -rf /var/lib/apt/lists/*

# Prepare build environment
ADD "http://npm.taobao.org/mirrors/node/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" /opt/
RUN find /opt/node-$NODE_VERSION-linux-x64/bin/* -exec ln -s '{}' /usr/local/bin/ \; \
	&& npm --registry=http://registry.npm.taobao.org -g install gitbook-cli \
	&& mkdir -p ~/.gitbook/versions/
	&& npm --registry=http://registry.npm.taobao.org install gitbook@$NODE_VERSION
	&& mv node_modules/gitbook ~/.gitbook/versions/$GITBOOK_VERSION
	&& rm -rf node_modules

# Load source
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# Build and Delivery
RUN make build \
	&& rm -rf /usr/share/nginx/html/ \
	&& cp /usr/src/app/dist /usr/share/nginx/html/

EXPOSE 80
