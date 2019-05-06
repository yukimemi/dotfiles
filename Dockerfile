FROM ubuntu
LABEL maintainer "yukimemi <yukimemi@gmail.com>"

# Use next 2 steps.
# docker build --tag yukimemi/dotfiles --build-arg USERNAME=yukimemi .
# docker run --rm -it -v $PWD:/home/yukimemi/.ghq/src/github.com/yukimemi/dotfiles:ro yukimemi/dotfiles

ARG USERNAME=yukimemi

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

# Environment setting.
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y \
      && apt upgrade -y \
			&& apt install -y --no-install-recommends apt-utils locales

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
RUN locale-gen ja_JP.UTF-8

RUN apt install -y sudo git curl build-essential

# Set localtime.
RUN ln -snvf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# clean up
RUN apt upgrade -y && apt clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# adduser ${USERNAME}:${USERNAME} with password '${USERNAME}'
RUN groupadd -g 1000 ${USERNAME} \
      && useradd -g ${USERNAME} -G sudo -m -s /bin/bash ${USERNAME} \
      && echo "${USERNAME}:${USERNAME}" | chpasswd

RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}/
CMD ["/bin/bash"]

