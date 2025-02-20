# use the current LTS version
FROM ubuntu:24.04

ARG CACHEBURST=PL3

# this is a script
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# update apt
RUN apt-get update
RUN apt-get -y upgrade

# libs required to install python
RUN apt-get install build-essential libssl-dev libffi-dev python3-dev -f -y
RUN apt-get install libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -f -y
RUN apt-get install curl wget -y

# install python, version of Oct 2024
RUN mkdir /tmp/Python313 \
    && cd /tmp/Python313 \
    && wget https://www.python.org/ftp/python/3.13.2/Python-3.13.2.tar.xz \
    && tar xvf Python-3.13.2.tar.xz \
    && cd /tmp/Python313/Python-3.13.2 \
    && ./configure --enable-optimizations  \
    && make altinstall

# make this python version the default
RUN ln -s /usr/local/bin/python3.13 /usr/bin/python
RUN unlink /usr/bin/python3
RUN ln -s /usr/local/bin/python3.13 /usr/bin/python3
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py


# Python Package Managers
RUN pip install --upgrade pip

#RUN curl -sSL https://install.python-poetry.org | python -
RUN pip install poetry
RUN poetry self add poetry-dotenv-plugin
RUN poetry self add poetry-plugin-bundle


CMD ["poetry", "-v"]