FROM ubuntu:24.04

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get autoremove -y \
	&& apt-get autoclean -y \
	&& apt-get install -y \
	sudo \
	nano \
	wget \
	curl \
	git \
	build-essential \
	gcc \
	openjdk-21-jdk \
	mono-complete \
	python3 \
	strace \
	valgrind


RUN useradd -G sudo -m -d /home/lisera -s /bin/bash -p "$(opensslpasswd -1 brannest1804)" lisera

USER lisera
WORKDIR /home/lisera

RUN mkdir hacking \
	&& cd hacking \
	&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
	&& chmod 764 pawned.sh \
	&& cd ..

RUN git config --global user.email "lise_rannestad@hotmail.com" \
	&& git config --global user.name "Lise Nilsen Rannestad" \
	&& git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
	&& mkdir -p github.com/GITHUB-liserannestad/sem02v24
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-arm64.tar.gz \
	| tar xvz -C /usr/local
USER lisera
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/lisera/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"

ARG DEBIAN_FRONTEND=noninteractive

RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf \
| sh -s -- -y
ENV PATH="${PATH}:${HOME}/.cargo/bin"