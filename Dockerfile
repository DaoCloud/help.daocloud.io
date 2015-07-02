FROM nginx

ENV NODE_VERSION 0.10.33
ENV NPM_VERSION 2.1.10

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& npm install -g npm@"$NPM_VERSION" 

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


EXPOSE 80
