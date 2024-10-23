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


cd ${MAIN_PATH}

mkdir notebooks

cd ${NOTEBOOK_PATH}


poetry run jupyter lab --port $JUPYTER_PORT