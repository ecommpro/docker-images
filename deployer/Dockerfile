FROM alpine:3.8

LABEL maintainer "EcommPro SL <dev@ecomm.pro>"

RUN apk update && apk add \
    git \
    openssh-client \
    rsync \
    lftp \
&& rm -fr /var/cache/apk/*