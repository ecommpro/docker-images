FROM alpine:3.8

LABEL maintainer "EcommPro SL <dev@ecomm.pro>"

RUN \
    mkdir -p /etc/ssh /work \
    && apk add --update openssh-keygen \
    && rm -fr /var/cache/apk/*

WORKDIR /work

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]