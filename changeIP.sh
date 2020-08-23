#!/bin/bash
# 在NAS中运行changeIP.sh

# 修改为自己的文件位置
DIR_IP='/volume1/docker/better-cf-ip/ip.txt'
DIR_CONFIG='/volume1/docker/v2fly/config.json'

# 启动 better-cf-ip ; 得到结果后自动关闭
docker start better-cf-ip

# 等待3分钟，让 best-cf-ip 运行结束，得到 ip.txt
sleep 3m

# 3分钟后，如果还没运行完，说明网络状态都很差，就关闭 docker，使用原来的 ip
docker stop better-cf-ip

# 读取 ip.txt 并赋值给变量 ip
ip=$(cat $DIR_IP)

# 修改v2ray config cf ip
# sed 使用双引号才能识别变量 $ip ; 双引号内部的双引号需要转义
sed -i "s/\(\"address\":\"\)\(.*\)\(\",\)/\1$ip\3/g" $DIR_CONFIG

# 重启 v2ray 使配置生效
docker restart v2fly
