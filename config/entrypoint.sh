#!/usr/bin/bash
# THIS IS THE TEST AND PRODUCTION ENTRYPOINT

# load the environment variables
set -a # automatically export all variables
if [ -f ./config/.env ]; then
    source ./config/.env
else
    echo "Warning: ./config/.env file not found."
    JUPYTER_PORT=8888
    JUPYTER_ENV=production
fi
set +a

cd ~
mkdir .jupyter

# copy the jupyter configuration into home-directory
cp -r ${CONFIG_PATH}/jupyter_lab_config.py ~/.jupyter/jupyter_lab_config.py
cp -r ${CONFIG_PATH}/jupyter_server_config.py ~/.jupyter/jupyter_server_config.py


# load the ssh-key if it exists
if [ -f ${NOTEBOOK_PATH}/.ssh/id_ed25519 ]; then
    mkdir -p ~/.ssh
    cp ${NOTEBOOK_PATH}/.ssh/id_ed25519 ~/.ssh/id_ed25519
    cp ${NOTEBOOK_PATH}/.ssh/id_ed25519.pub ~/.ssh/id_ed25519.pub
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
fi


cd ${MAIN_PATH}

mkdir notebooks

cd ${NOTEBOOK_PATH}


poetry run jupyter lab --port $JUPYTER_PORT