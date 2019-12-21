FROM jetbrains/teamcity-agent:2019.2

ENV DEBIAN_FRONTEND=noninteractive
ENV GO_VERSION=1.13.5

RUN apt-get update \
    && apt-get install wget -y \
    && apt-get install awscli -y

# Install golang
RUN wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -xvf go${GO_VERSION}.linux-amd64.tar.gz \
    && mv go /usr/local \
    && rm go${GO_VERSION}.linux-amd64.tar.gz \
    && mkdir /golang

ENV GOROOT=/usr/local/go
ENV GOPATH=/golang
ENV PATH=${GOROOT}/bin:$PATH
ENV DOCKER_IN_DOCKER=start
