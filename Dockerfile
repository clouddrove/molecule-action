FROM python:3.8-alpine AS builder

ARG BUILD_DEPS="\
    gcc \
    libc-dev \
    make \
    musl-dev \
    libffi-dev \
    openssl-dev \
    "

ARG PIP_INSTALL_ARGS="\
    --no-cache-dir \
    "

ARG PIP_MODULES="\
    molecule[docker]==3.0.8 \
    "

RUN apk add --update --no-cache ${BUILD_DEPS} && \
    pip install ${PIP_INSTALL_ARGS} ${PIP_MODULES}

FROM python:3.8-alpine

ARG PACKAGES="\
    docker \
    git \
    openssh-client\
    "

RUN apk add --update --no-cache ${PACKAGES} && \
    rm -rf /root/.cache

COPY --from=builder /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
COPY --from=builder /usr/local/bin/ansible*  /usr/local/bin/
COPY --from=builder /usr/local/bin/molecule  /usr/local/bin/molecule

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
