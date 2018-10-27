FROM alpine:edge
MAINTAINER yukimemi <yukimemi@gmail.com>

ARG USERID=1000
ARG GROUPID=1000
ARG USERNAME=yukimemi
ARG GROUPNAME=staff
ARG HOMEPATH=/Users/yukimemi

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    shadow \
    curl \
    gcc \
    git \
    linux-headers \
    musl-dev\
    neovim \
    python-dev \
    py-pip \
    python3-dev \
    py3-pip && \
    rm -rf /var/cache/apk/*

ENV LANG="ja_JP.UTF-8" LANGUAGE="ja_JP:ja" LC_ALL="ja_JP.UTF-8"

RUN pip3 install --upgrade pip neovim
RUN mkdir -p ${HOMEPATH}
# RUN addgroup -g ${GROUPID} ${GROUPNAME} > /dev/null 2>&1
# RUN adduser -D -S -u ${USERID} -h ${HOMEPATH} -G ${GROUPNAME} ${USERNAME}

COPY .config ${HOMEPATH}/.config

RUN groupadd -g ${GROUPID} ${GROUPNAME}; exit 0
RUN useradd -u ${USERID} -g ${GROUPID} -d ${HOMEPATH} -s /bin/bash ${USERNAME}
RUN chown -R ${USERID}:${GROUPID} ${HOMEPATH}

USER ${USERNAME}
WORKDIR ${HOMEPATH}

RUN nvim +UpdateRemotePlugins +qa

ENTRYPOINT ["nvim"]
