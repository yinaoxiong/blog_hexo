#!/bin/bash
# This script builds a Docker image for a Hexo blog environment.

docker build --build-arg UBUNTU_VERSION=24.04 --build-arg VOLTA_VERSION=2.0.2 -t ghcr.io/yinaoxiong/blog_hexo:base -f .devcontainer/Dockerfile .