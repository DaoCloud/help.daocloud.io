FROM python:2.7.8

ENV NODE_VERSION 0.10.33
ENV NPM_VERSION 2.1.10

RUN curl -SLO "http://npm.taobao.org/mirrors/node/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
        && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1

RUN npm  --registry=https://registry.npm.taobao.org -g install gitbook-cli

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./src/book.json /usr/src/app/src

RUN gitbook install

COPY . /usr/src/app

RUN make build

CMD python -m SimpleHTTPServer
EXPOSE 8000