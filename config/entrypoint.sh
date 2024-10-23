#!/usr/bin/bash
# THIS IS THE TEST AND PRODUCTION ENTRYPOINT

# load the environment variables
set -a # automatically export all variables
source ./config/.env # the path where we put the env-file, away from the volume that would override it!
set +a

cd ~
mkdir .jupyter

# copy the jupyter configuration into home-directory
cp -r ${CONFIG_PATH}/jupyter_lab_config.py ~/.jupyter/jupyter_lab_config.py


cd ${MAIN_PATH}

mkdir notebooks

cd ${NOTEBOOK_PATH}


poetry run jupyter lab --port $JUPYTER_PORT