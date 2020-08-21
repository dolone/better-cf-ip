FROM ubuntu:18.04
RUN apt update -y && \
    apt install curl -y && \
    apt install build-essential -y && \
    apt install git -y
WORKDIR /root
RUN git clone https://github.com/dolone/better-cf-ip.git && \
    cd better-cf-ip && \
    cd fping-4.2 && \
    ./configure && \
    make
CMD ["/root/better-cf-ip/fping-4.2/src/cf.sh"]
