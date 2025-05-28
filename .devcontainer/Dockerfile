# The version of Ubuntu to use.
# (Defaults to 24.04)
ARG UBUNTU_VERSION=24.04

FROM ubuntu:${UBUNTU_VERSION}

# The version of Volta to install.
# (Defaults to latest)
ARG VOLTA_VERSION=latest

RUN \
    # Update packages
    apt-get update \
    #
    # Install package dependencies
    && apt-get install -y \
    ca-certificates \
    curl \
    git \
    wget \
    sudo \
    locales \
    openssh-client gnupg2 \
    --no-install-recommends \
    # 配置区域设置
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8


SHELL ["/bin/bash", "-c"]

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu


ENV BASH_ENV=/home/ubuntu/.bashrc
ENV VOLTA_HOME=/home/ubuntu/.volta
ENV PATH=$VOLTA_HOME/bin:$PATH

RUN \
    # Install Volta
    if [ "${VOLTA_VERSION}" = "latest" ]; \
    then \
    curl https://get.volta.sh | bash; \
    else \
    curl https://get.volta.sh | bash -s -- --version ${VOLTA_VERSION}; \
    fi \
    # Test install
    && ls -l ~/.volta/bin \
    && volta --version


ARG NODE_VERSION=22.16.0
ARG PNPM_VERSION=10.11.0

# install target node version and pnpm
RUN \
    volta install node@${NODE_VERSION} \
    && volta install pnpm@${PNPM_VERSION} \
    # Test install
    && node --version \
    && pnpm --version

# 设置工作目录
WORKDIR /workspace

COPY package*.json pnpm-lock.yaml ./

RUN \
    # 安装依赖
    pnpm install --frozen-lockfile --prefer-offline \
    # 清理缓存
    && pnpm store prune