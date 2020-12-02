FROM python:3.7-alpine

ARG BUILD_DEPS="\
    gcc \
    libc-dev \
    make \
    musl-dev \
    libffi-dev \
    openssl-dev \
    "

ARG PACKAGES="\
    docker \
    git \
    openssh-client \
    "

ENV PIP_INSTALL_ARGS="\
    --no-cache-dir \
    "

ARG INPUT_PIP_MODULES="\
    netaddr \
    "

ARG MOLECULE_EXTRAS="docker"

RUN pip install ansible molecule[docker] docker

RUN apk add --update --no-cache ${BUILD_DEPS} ${PACKAGES} && \
    pip install ${PIP_INSTALL_ARGS} ${INPUT_PIP_MODULES} && \
    apk del --no-cache ${BUILD_DEPS} && \
    rm -rf /root/.cache

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
