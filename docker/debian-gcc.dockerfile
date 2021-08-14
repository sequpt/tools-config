ARG SUITE=bullseye-slim
FROM debian:${SUITE} AS base
RUN echo 'deb http://deb.debian.org/debian bullseye-backports main' > /etc/apt/sources.list.d/backports.list

FROM base AS gcc
ARG USER=default
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        binutils \
        gcc \
        libc-dev \
        make \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt /var/lib/dpkg

FROM gcc AS final
ARG USER=default
RUN useradd -u 1000 -m ${USER} --no-log-init
ENV HOME=/home/${USER}
WORKDIR ${HOME}
USER ${USER}
