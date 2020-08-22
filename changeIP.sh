#!/bin/bash
# changeIP.sh 放在 NAS 中 ;
# 与 ip.txt 和 config.json 处于同一目录 ;
# 用 ln 硬链接创建 config.json

# 先进入操作目录
cd /volume1/docker/better-cf-ip

# 启动 better-cf-ip ; 得到结果后自动关闭
docker start better-cf-ip

# 等待5分钟，让 best-cf-ip 运行结束，得到 ip.txt
sleep 5m

# 5分钟后，如果还没运行完，说明网络状态都很差，就关闭 docker，使用原来的 ip
docker stop better-cf-ip

# 读取 ip.txt 并赋值给变量 ip
ip=$(cat ./ip.txt)

# 修改v2ray config cf ip
# sed 使用双引号才能识别变量 $ip ; 双引号内部的双引号需要转义
sed -i "s/\(\"address\":\"\)\(.*\)\(\",\)/\1$ip\3/g" ./config.json

# 重启 v2ray 使配置生效
docker restart v2fly
