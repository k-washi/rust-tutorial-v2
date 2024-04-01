FROM ubuntu:22.04

# Set timezone
RUN ln --symbolic --force /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Set locales
ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C.UTF-8" \
    LANG="C.UTF-8"

RUN apt-get update -y && apt-get install -y build-essential vim \
    sudo wget curl git zip openssl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

ARG project_name=rustenv
ARG uid=1001
ARG gid=1001
ARG username=ruser
ARG APPLICATION_DIRECTORY=/home/${username}/${project_name}

RUN echo "uid ${uid}"
RUN echo "gid ${gid}"
RUN echo "username ${username}"
# RUN groupadd -r -f -g ${gid} ${username} && useradd -o -r -l -u ${uid} -g ${gid} -ms /bin/bash ${username}
RUN addgroup --gid ${gid} ${username} && \
    adduser --disabled-password --gecos '' --uid ${uid} --gid ${gid} ${username} && \
    usermod --append --groups sudo ${username} && \
    echo '%sudo ALL=(ALL:ALL) NOPASSWD:ALL' >> '/etc/sudoers'


USER ${username}

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y
RUN sudo ln -s $HOME/.cargo/env /etc/profile.d/cargo_env.sh
WORKDIR ${APPLICATION_DIRECTORY}