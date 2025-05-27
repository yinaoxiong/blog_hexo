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
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*


SHELL ["/bin/bash", "-c"]

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


ARG NODE_VERSION=12.4.0
ARG NPM_VERSION=7.10.0

# install target node version and npm
RUN \
    volta install node@${NODE_VERSION} \
    && volta install npm@${NPM_VERSION} \
    # Test install
    && node --version \
    && npm --version

# 设置工作目录
WORKDIR /workspace

# 复制 package.json 和 package-lock.json
COPY package*.json ./

RUN \
    # 安装依赖
    npm ci \
    # 清理缓存
    && npm cache clean --force