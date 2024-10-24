

# PyQML-Lab


PyQML-lab is your ready-to-start **quantum algorithm** development environment configuration.
It runs Python, JupyterLab, Qiskit, and other required libraries and packages in a Docker container and automates the whole setup using scripts.
Scripts automate executing all the commands you would normally need to run manually.
For you can review and edit scripts, you get full control of your configuration at any time.




## Repository Overview

**Last Update: Oct 24, 2024**

The base image is published at [Docker Hub](https://hub.docker.com/r/pyqml/lab).
You can find the source code at [GitHub](https://github.com/quantum-machine-learning/pyqml-lab).


Versions:

- Ubuntu 24.04
- Python 3.13.0
- JupyterLab 4.2.5
- Qiskit 1.2.4


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



## Changelog

**2024-10-24 v24.10.2**
- Added git and JupyterLab git extension
- load .ssh-config when stored in `notebooks/.ssh/`
- Added server config (allow to show hidden files)

**2024-10-22 v24.10.1** - Initial Release 