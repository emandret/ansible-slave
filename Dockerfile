FROM alpine:3.13

LABEL maintainer="edwy.mandret@traydstream.com"

ARG ANSIBLE_VERSION=3.0
ARG ANSIBLE_LINT_VERSION=5.0.2
ARG MITOGEN_VERSION=0.2.9

# --no-cache: index is updated and used on the fly but not cached locally
RUN apk --no-cache add \
    ca-certificates \
    git \
    openssh-client \
    openssl \
    python3 \
    py3-pip \
    py3-cryptography \
    rsync \
    sshpass \
    curl

# packages added under the virtual name build-dependencies can then be removed as one group
RUN apk --update-cache add --virtual build-dependencies \
    python3-dev \
    libffi-dev \
    openssl-dev \
    build-base \
    && pip3 install --upgrade pip cffi \
    && pip3 install ansible==${ANSIBLE_VERSION} \
    && pip3 install ansible-lint==${ANSIBLE_LINT_VERSION} \
    && curl -fsSL https://networkgenomics.com/try/mitogen-${MITOGEN_VERSION}.tar.gz | tar x -zf - -C /opt \
    && ln -s /opt/mitogen-${MITOGEN_VERSION} /opt/mitogen \
    && apk del build-dependencies

COPY ./ansible_ssh_config /etc/ssh/ssh_config

WORKDIR /home/ansible-workspace

CMD ["/bin/sleep", "9999"]
