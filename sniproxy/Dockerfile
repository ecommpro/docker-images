FROM alpine:3.8

LABEL maintainer "EcommPro SL <dev@ecomm.pro>"

RUN \
    mkdir -p /work \
    && apk add --update sniproxy \
    && rm -fr /var/cache/apk/*

WORKDIR /work

EXPOSE 80
EXPOSE 443

COPY sniproxy.conf /etc/sniproxy.conf

CMD ["/usr/sbin/sniproxy","-c","/etc/sniproxy.conf","-f"]