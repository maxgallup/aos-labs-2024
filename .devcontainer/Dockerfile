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

# Terminal prompt customizations
COPY --chown=dev:dev custom/.bashrc /home/dev/.bashrc

