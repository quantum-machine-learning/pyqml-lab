

# PyQML-Lab


PyQML-lab is your ready-to-start **quantum algorithm** development environment configuration.
It runs Python, JupyterLab, Qiskit, and other required libraries and packages in a Docker container and automates the whole setup using scripts.
Scripts automate executing all the commands you would normally need to run manually.
For you can review and edit scripts, you get full control of your configuration at any time.




## Repository Overview

**Last Update: April 28, 2025**

The base image is published at [Docker Hub](https://hub.docker.com/r/pyqml/lab).
You can find the source code at [GitHub](https://github.com/quantum-machine-learning/pyqml-lab).


Versions:

- Ubuntu 24.04
- Python 3.13.3
- JupyterLab 4.4.1
- Qiskit 2.0.0


## Start


The following picture shows `pyqml-lab` in action. **Use** it with two simple steps:

1. Execute `bash {path_to_your_project}/run.sh`
1. Open `localhost:8888` from a browser

<table class="image">
<tr><td><img src="config_use.png" width="600"></td></tr>
<tr><td class="caption" >Using the JupyterLab configuration</td></tr>
</table>

## Customization

### Add new Python libraries/packages

Inside Jupyterlab, open a terminal and run `poetry add {package_name}`.

You can also add the package to the `pyproject.toml` file and run `poetry install`.

### Add Operating System packages

You can add new packages to the `lab.Dockerfile` and restart Jupyterlab (stop any running container and run `bash run.sh`).

### Set password

1. Open a Python3 console
1. run command `from jupyter_server.auth import passwd`
1. run `passwd()`
1. enter your password
1. copy the output to the `jupyter_lab_config.py` file
1. the final line should look like `c.ServerApp.password = 'argon2:$argon2id$v=19$m=10240,t=10,p=8...pg'`
1. restart JupyterLab

## Changelog

**2025-04-28 v25.04.0**
- Update Python to v3.13.3
- Update JupyterLab to v4.4.1
- Update Qiskit to v2.0.0
- Update Qiskit-Aer to v0.17.0
- Added qiskit_ibm_runtime 0.38.0
- Added qiskit-machine-learning 0.8.2
- Update Numpy to v2.2.5
- Update Matplotlib to v3.10.1


**2025-02-20 v25.02.0**
- Added qiskit-finance (v0.4.1)
- Update Python to v3.13.2
- Update JupyterLab to v4.3.5
- Update Qiskit to v1.3.2


**2024-12-03 v24.12.1**
- Added Qiskit-Aer


**2024-10-24 v24.10.2**
- Added git and JupyterLab git extension
- load .ssh-config when stored in `notebooks/.ssh/`
- Added server config (allow to show hidden files)

**2024-10-22 v24.10.1** - Initial Release 