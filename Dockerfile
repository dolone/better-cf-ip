FROM alpine

# install gcc curl bash
# remove gcc after make
# --no-cache 选项允许不在本地缓存索引，这对于保持容器较小很有用
# 需要安装 bash 来执行脚本，/bin/sh 语法不同
# 需要给脚本加执行权限
# 需要 sh ./configure，否则 Permission denied
RUN apk update && \
    apk add --no-cache gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    apk add --no-cache curl && \
    apk add --no-cache bash bash-doc bash-completion && \
    cd /root && \
    curl -LJO https://github.com/dolone/better-cf-ip/archive/latest.tar.gz && \
    tar -xvf better-cf-ip-latest.tar.gz && \
    cd better-cf-ip-latest && \
    cd fping-4.2 && \
    sh ./configure && \
    make && \
    chmod +x /root/better-cf-ip-latest/fping-4.2/src/cf.sh && \
    apk del gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

WORKDIR /root

VOLUME ["/root"]

CMD ["/bin/bash", "-c", "/root/better-cf-ip-latest/fping-4.2/src/cf.sh"]
