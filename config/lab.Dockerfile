
ARG JUPYTER_ENV=production

FROM pyqml/lab:24.10.1 AS base

###############################################################################
# Add system-level dependencies here                                          #
###############################################################################



###############################################################################
# Paths                                                                       #
###############################################################################
ENV MAIN_PATH=/usr/local/bin/lab
ENV CONFIG_PATH=${MAIN_PATH}/config
ENV NOTEBOOK_PATH=${MAIN_PATH}/notebooks

WORKDIR ${MAIN_PATH}

COPY pyproject.toml .


# see: https://stackoverflow.com/questions/74385209/poetry-install-throws-connection-pool-is-full-discarding-connection-pypi-org
RUN poetry config installer.max-workers 10



ARG JUPYTER_ENV=production
ENV JUPYTER_ENV=${JUPYTER_ENV}

ARG JUPYTER_PORT=8888
ENV JUPYTER_PORT=${JUPYTER_PORT}

###############################################################################
#   Development                                                               #
###############################################################################
# Build dev image
FROM base AS interim-development
RUN poetry install



###############################################################################
#   Production                                                                #
###############################################################################
FROM base AS interim-production

RUN poetry install 

###############################################################################
#   INTERIM                                                                   #
###############################################################################
FROM interim-${JUPYTER_ENV} AS interim

EXPOSE ${JUPYTER_PORT}

###############################################################################
#   Development                                                               #
###############################################################################
FROM interim AS final-development

SHELL ["/bin/bash", "-c"]
CMD ["bash", "config/dev.sh"]

###############################################################################
#   Production                                                                #
###############################################################################
FROM interim AS final-production

# see: https://scheele.hashnode.dev/build-a-dockerized-fastapi-application-with-poetry-and-gunicorn
#CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "src.app:app", "--bind", "0.0.0.0:80"]

ENTRYPOINT ["./config/entrypoint.sh"]



###############################################################################
#   FINAL                                                                   #
###############################################################################
FROM final-${JUPYTER_ENV} AS final



#CMD cd ${MAIN_PATH} && sh config/run_jupyter.sh
