FROM jetbrains/teamcity-agent:2019.2

ENV DEBIAN_FRONTEND=noninteractive
ENV GO_VERSION=1.13.5

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

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
