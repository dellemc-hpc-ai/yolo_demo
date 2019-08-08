# Written by Seth Barberee, Undergraduate Intern
# Created on 7/10/19
# Using a pre-built image from the YOLO directory,
# run YOLO containerized in Docker


#! /bin/bash

# Explanation of flags
# -v /dev/video - let container access webcam on video0

# Using the below flags, connect X11 server to Docker
# -v /tmp/.X11-unix
# -e DISPLAY=$DISPLAY


# Make sure webcam is there
if [ ! -d `/dev/video0` ]; then
	echo "=> Is the webcam plugged in?"
	exit 1
fi

# IF the directory is there but not symlink, we gotta delete it
if [ ! -L `/dev/video0` ]; then
	echo "=> rm -r /dev/video0 and replug webcam"
	exit 1
fi

# Shim up X11 display to docker
docker run --rm --privileged -v /dev/video0:/dev/video0 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=$DISPLAY \
	--name "yolo-docker" \
	dellemchpcai/yolo_demo:latest
