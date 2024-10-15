

# Getting Started

In order to get all necessary dependencies installed for this project we recommend to get started with following one of the supported methods below.


## With Docker only
*This method requires `docker`.*

We provide the following Makefile target to start an interactive shell with all dependencies installed. Simply run `make docker` which will build and start a shell inside the container. This will mount the root of the project into the container so all of the files on your host will be inside the container as well. Then use `make grade` to verify everything works.


## With VSCode + Docker
*This method requires `docker` and `VSVode`.*

VSCode ships an extension called [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) which allows you to open a repository inside of a Docker container that has all necessary development tools installed. This isolates your development environment from your host machine. Simply install the extension, then run the _"Dev Containers: Rebuild and Reopen inside Container"_ command from VSCode's command palette (Ctrl+P). It will take a while to build the container, however after that it will be cached and can be opened quickly.

Note, that VSCode installs a development environment inside the container itself and lets you use a shell inside the container. This will obviously be different from the shell on you native machine, so feel free to add anything to the [Dockerfile](.devcontainer/Dockerfile) to suite your needs. Since we are running the project inside a docker container, we don't need to be worried about polluting our host's system with various versions of clang. After opening in the devcontainer environment, run `make grade` to verify that everything works.


## With Devbox (Nix)
*This method requires `devbox`.*

[Devbox](https://www.jetify.com/devbox) is a wrapper built on top of the nix package manager and can make reproducibility very easy. This option has the benefit of keeping your host's development environment. If you have devbox installed, simply run `devbox shell` and all dependencies will be resolved. Then run `make grade` to verify everything works.


