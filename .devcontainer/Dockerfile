FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y

RUN apt update --fix-missing && apt install -y \
	sudo \
	build-essential \
	curl \
	git \
	make \
	python3 \
	python-is-python3 \
	wget

RUN apt update --fix-missing && apt install -y \
	clang \
	llvm \
	lld \
	gdb \
	qemu-system


# Add custom user "dev" with sudo permissions
RUN useradd dev -u 1000 -m -s /bin/bash && \
	echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER dev


# Install GEF for sanity & its dependencies
RUN sudo apt install -y file && bash -c "$(wget https://gef.blah.cat/sh -O -)"

# Terminal prompt customizations
COPY custom/gu /usr/local/bin/gu
COPY custom/.bashrc /home/dev/.bashrc
RUN sudo chown dev:dev /usr/local/bin/gu
RUN sudo chown dev:dev /home/dev/.bashrc

