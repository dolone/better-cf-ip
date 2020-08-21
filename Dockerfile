FROM alpine

RUN apk update && \
    apk add gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    apk add curl && \
    cd /root && \
    curl -LJO https://github.com/dolone/better-cf-ip/archive/latest.tar.gz && \
    tar -xvf better-cf-ip-latest.tar.gz && \
    cd better-cf-ip-latest && \
    cd fping-4.2 && \
    sh ./configure && \
    make && \
    apk del gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    rm -rf /var/cache/* && \
    rm -rf /tmp/*

WORKDIR /root

VOLUME ["/root"]

CMD ["sh", "-c", "/root/better-cf-ip-latest/fping-4.2/src/cf.sh"]
