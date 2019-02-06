FROM alpine:3.8
LABEL maintainer "EcommPro SL <dev@ecomm.pro>"
RUN apk --update add openssl

RUN echo $'\
[ v3_req ]\n\
basicConstraints = CA:FALSE\n\
keyUsage = nonRepudiation, digitalSignature, keyEncipherment\n\
\n\
[ v3_ca ]\n\
subjectKeyIdentifier=hash\n\
authorityKeyIdentifier=keyid:always,issuer\n\
basicConstraints = critical,CA:true\n'\
>> /etc/ssl/openssl.cnf

