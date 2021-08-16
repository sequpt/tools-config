ARG SUITE=buster-slim
FROM debian:${SUITE} AS base
ARG GCC_VERSION=7
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        binutils \
        gcc-${GCC_VERSION} \
        libc-dev \
        make \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt /var/lib/dpkg \
    && ln -sf /usr/bin/gcc-${GCC_VERSION} /usr/bin/gcc

FROM base AS final
ARG USER=default
RUN useradd -u 1000 -m ${USER} --no-log-init
ENV HOME=/home/${USER}
WORKDIR ${HOME}
USER ${USER}
