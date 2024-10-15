#!/bin/bash

IMAGE_NAME="aos-dev"
CONTAINER_NAME="aos-dev-container"
CONTAINER_ENTRY="/usr/bin/bash"
WORK_DIR="/home/dev/work"

PROJECT_ROOT="$(pwd)"

# function contianer_run() {
# 	sudo docker run -w $WORK_DIR --rm --hostname dev -it  -v $PROJECT_ROOT:$WORK_DIR:z $IMAGE_NAME $CONTAINER_ENTRY
# }

function container_stop() {
	sudo docker stop $CONTAINER_NAME || echo "container already stopped"
}

function clean() {
	container_stop
	sudo docker rm $CONTAINER_NAME || echo "container already removed"
	sudo docker image rm $IMAGE_NAME  || echo "image already removed"
}

function container_start() {
	if [ -z "$(sudo docker ps -a | grep $CONTAINER_NAME)" ]; then
		echo ">> creating dev container"

		sudo docker run -w $WORK_DIR --hostname dev -it --name $CONTAINER_NAME \
			--net=host \
			--cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
			-v $PROJECT_ROOT:$WORK_DIR:z \
			$IMAGE_NAME $CONTAINER_ENTRY

	else
		echo ">> found existing dev container"
		sudo docker start $CONTAINER_NAME
		sudo docker exec -it $CONTAINER_NAME $CONTAINER_ENTRY

		# if [ -z "$(sudo docker ps -a | grep $CONTAINER_NAME | grep "Up")" ]; then
		# else
		# fi


		# echo "container exists already"
		# sudo docker run -w $WORK_DIR --hostname dev -it \
		# 	--cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
		# 	-v $PROJECT_ROOT:$WORK_DIR:z \
		# 	$IMAGE_NAME $CONTAINER_ENTRY
	fi
}


function image_build() {
	if [ -z "$(sudo docker images | grep $IMAGE_NAME)" ]; then
		echo ">> building image: $IMAGE_NAME"
		sudo docker build -t $IMAGE_NAME .devcontainer/
	fi
}


function print_usage() {
	echo "Usage ./docker.sh [container-start/stop | image-build | clean]"
}



function main() {
	if ! command -v docker 2>&1 >/dev/null; then
		echo "Could not find docker. Please install it https://docs.docker.com/engine/install/"
		exit 1
	fi

	if [ -z "$1" ]; then
		print_usage 
	elif [ "$1" = "container-start" ]; then
		container_start
	elif [ "$1" = "container-stop" ]; then
		container_stop
	elif [ "$1" = "clean" ]; then
		clean
	elif [ "$1" = "image-build" ]; then
		image_build
	else
		print_usage
	fi

}


main $@

