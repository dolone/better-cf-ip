FROM alpine

# install gcc curl bash
# remove gcc after make
# 使用 curl 下载源码 zip 压缩包
# --no-cache 选项允许不在本地缓存索引，这对于保持容器较小很有用
# 需要安装 bash 来执行脚本，/bin/sh 语法不同
# 需要给脚本加执行权限
# 需要 sh ./configure，否则 Permission denied
RUN apk update && \
    apk add --no-cache gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    apk add --no-cache curl && \
    apk add --no-cache bash bash-doc bash-completion && \
    cd /root && \
    curl -LJO https://github.com/duxlong/better-cf-ip/archive/master.zip && \
    unzip better-cf-ip-master.zip && \
    cd better-cf-ip-master && \
    cd fping-4.2 && \
    sh ./configure && \
    make && \
    chmod +x /root/better-cf-ip-master/fping-4.2/src/cf.sh && \
    mkdir /root/result && \
    apk del gcc make openssl-dev zlib-dev perl-dev pcre-dev libc-dev && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

# 需要在此目录执行脚本
WORKDIR /root/better-cf-ip-master/fping-4.2/src

# 运行结果 /root/result/ip.txt
VOLUME ["/root/result"]

CMD ["/bin/bash", "-c", "./cf.sh"]
