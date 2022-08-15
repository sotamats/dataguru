FROM alpine:edge

RUN apk add --no-cache \
        lsyncd \
        openssh-client \
    && rm -rf /var/cache/apk/*

# Prepare user
ARG DEFAULT_USER="dataguru"
ARG HOME_DIR="/home/${DEFAULT_USER}"
RUN addgroup -S ${DEFAULT_USER} && adduser -S ${DEFAULT_USER} -G ${DEFAULT_USER} -h ${HOME_DIR} \
    && chown -R ${DEFAULT_USER}:${DEFAULT_USER} ${HOME_DIR} \
    && mkdir -p ${HOME_DIR}/.ssh

# SSH key to server
COPY id_rsa_dataguru ${HOME_DIR}/.ssh/
COPY ssh-config ${HOME_DIR}/.ssh/config
RUN chown -R ${DEFAULT_USER}:${DEFAULT_USER} ${HOME_DIR}/.ssh \
    && chmod og-rwx ${HOME_DIR}/.ssh/*

# Entrypoint
COPY .entrypoint.sh /opt/.entrypoint.sh
RUN chmod +x /opt/.entrypoint.sh

USER ${DEFAULT_USER}
WORKDIR ${HOME_DIR}
ENTRYPOINT ["/bin/sh", "-c", "/opt/.entrypoint.sh \"${@}\"", "--"]
