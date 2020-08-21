FROM ubuntu:18.04
RUN apt-get update -y && \
    apt-get install curl -y && \
    apt-get install build-essential -y
WORKDIR /root
RUN curl -LJO https://github.com/dolone/better-cf-ip/archive/latest.tar.gz && \
    tar -xvf better-cf-ip-latest.tar.gz && \
    cd better-cf-ip-latest && \
    cd fping-4.2 && \
    ./configure && \
    make
CMD ["sh", "-c", "/root/better-cf-ip-latest/fping-4.2/src/cf.sh"]
