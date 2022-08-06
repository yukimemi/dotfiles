FROM anatolelucet/neovim:stable-ubuntu AS builder
LABEL maintainer "yukimemi <yukimemi@gmail.com>"

FROM --platform=linux/amd64 ubuntu:20.04
COPY --from=builder /usr/local /usr/local/

RUN apt update && apt upgrade -y && \
      apt install -y git curl zip unzip

RUN curl -fsSL https://deno.land/install.sh | sh

RUN echo 'export DENO_INSTALL="/root/.deno"' >> ~/.bashrc \
  && echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc

CMD ["/usr/local/bin/nvim"]
