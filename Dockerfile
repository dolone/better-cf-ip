FROM ubuntu:18.04
RUN apt update && apt install curl -y && apt install build-essential -y
WORKDIR /root
RUN git clone https://github.com/dolone/better-cf-ip.git && \
    tar -vxf fping-4.2.tar.gz && \
    cd fping-4.2 && \
    ./configure && \
    make
CMD ["/root/fping-4.2/src/cf.sh"]
