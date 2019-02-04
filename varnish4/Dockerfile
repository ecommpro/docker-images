FROM alpine:3.6

LABEL maintainer "EcommPro SL <dev@ecomm.pro>"

RUN apk update && apk add varnish

EXPOSE 6081
EXPOSE 6082

COPY default.vcl /etc/varnish/default.vcl
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]