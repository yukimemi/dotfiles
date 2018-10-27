FROM alpine:edge

MAINTAINER yukimemi <yukimemi@gmail.com>
ARG USERNAME=yukimemi

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
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

COPY .config /root/.config

RUN nvim +PackUpdate +UpdateRemotePlugins +qa

ENTRYPOINT ["nvim"]
