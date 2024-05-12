FROM alpine:3.19.1

LABEL org.opencontainers.image.source https://github.com/ivanmorenoj/nextcloud-client-docker

ARG VCS_REF
ARG BUILD_DATE
ARG buildno
ARG USER=ncsync
ARG USER_UID=1000
ARG USER_GID=1000

ENV USER=$USER \
    USER_UID=$USER_UID \
    USER_GID=$USER_GID \
    NC_USER="" \
    NC_PASS="" \
    NC_INTERVAL=300 \
    NC_URL="" \
    NC_TRUST_CERT=false \
    NC_SOURCE_DIR="/media/nextcloud/" \
    NC_PATH="" \
    NC_SILENT=false \
    NC_EXIT=false   \
    NC_HIDDEN=false


# create group and user
RUN addgroup -g $USER_GID $USER && adduser -G $USER -D -u $USER_UID $USER

# update repositories and install nextcloud-client
RUN apk add --no-cache nextcloud-client moreutils

# add run script
ADD run.sh /usr/bin/run.sh

CMD /usr/bin/run.sh