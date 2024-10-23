#!/bin/bash

# get the local IP address
export IP_ADDR=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')


# load the environment variables for the build process
set -a # automatically export all variables
if [ -f ./config/.env ]; then
    source ./config/.env
else
    echo "Warning: ./config/.env file not found."
    JUPYTER_PORT=8888
    JUPYTER_ENV=production
fi
set +a

echo Configuration: $JUPYTER_ENV $JUPYTER_PORT


docker build \
    -t pyqml-lab-local \
    -f config/lab.Dockerfile \
    --build-arg JUPYTER_ENV=$JUPYTER_ENV \
    --build-arg JUPYTER_PORT=$JUPYTER_PORT \
    .

docker rm pyqmllab

docker run -d -it \
    --name pyqmllab \
    -p $JUPYTER_PORT:$JUPYTER_PORT \
    -v "${PWD}:/usr/local/bin/lab" \
    -e POETRY_DOTENV_LOCATION=./config/.env \
    pyqml-lab-local

# OPENS THE SHELL, USEFUL FOR Configuring the environment
# docker exec -it pyqmllab bash


