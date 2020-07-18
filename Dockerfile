FROM jetbrains/teamcity-agent:2020.1.2-linux

USER root

ENV DEBIAN_FRONTEND=noninteractive
ENV GO_VERSION=1.14.1
ENV HUB_VERSION=2.14.2
ENV BUILDX_VERSION=v0.4.1

RUN apt-get update \
    && apt-get install wget gcc -y \
    && apt-get install awscli zip -y

# Install golang
RUN wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -xvf go${GO_VERSION}.linux-amd64.tar.gz \
    && mv go /usr/local \
    && rm go${GO_VERSION}.linux-amd64.tar.gz \
    && mkdir /golang

ENV GOROOT=/usr/local/go
ENV GOBIN=${GOROOT}/bin
ENV GOPATH=/golang
ENV PATH=${GOBIN}:$PATH
ENV DOCKER_IN_DOCKER=start

# Install golint
RUN go get -u golang.org/x/lint/golint

# Install dep
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Install hub
RUN wget https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz \
    && tar zxvf hub-linux-amd64-${HUB_VERSION}.tgz \
    && ./hub-linux-amd64-${HUB_VERSION}/install \
    && rm -rf hub-linux-amd64-${HUB_VERSION} hub-linux-amd64-${HUB_VERSION}.tgz

USER buildagent

# Install buildx plugin
RUN wget https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-amd64 \
    -O ~/.docker/cli-plugins/docker-buildx \
    chmod a+x ~/.docker/cli-plugins/docker-buildx
