FROM alpine:latest AS base
RUN apk update && apk add --no-cache doxygen graphviz make ttf-freefont
FROM base AS final
ARG USER=default
RUN adduser \
   --disabled-password \
   --no-create-home \
   --uid 1000 \
   ${USER}
ENV HOME=/home/${USER}
WORKDIR ${HOME}
USER ${USER}
