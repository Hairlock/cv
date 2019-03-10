ARG     NODE_VERSION=10.15.0

FROM    node:${NODE_VERSION} as builder

ENV PURESCRIPT_DOWNLOAD_SHA1 f0c9fae808ae27973de7c77519f87ae6e4837312

RUN npm install -g pulp@12.3.0 psc-package parcel-bundler

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.12.3/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz

ENV PATH /opt/purescript:$PATH

RUN userdel node
RUN useradd -m -s /bin/bash pureuser

WORKDIR /usr/src/app

COPY . .

ENV USER=pureuser \
    PATH=/opt/purescript:$PATH

RUN set -ex; \
    psc-package install; \
    psc-package build; \
    parcel build assets/index.html; \
    cp -a images/. dist/;



FROM mhart/alpine-node:latest

WORKDIR /app
COPY    --from=builder /usr/src/app/dist .

RUN yarn global add http-server
CMD ["http-server"]