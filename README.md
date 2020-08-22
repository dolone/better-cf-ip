# better-cf-ip

> build from https://github.com/badafans/better-cloudflare-ip

## step1.使用容器 better-cf-ip
docker pull duxlong/better-cf-ip

ps.映射 /root

## step2.使用脚本 changeIP.sh
a.关闭容器，再启动容器

b.等待 5 分钟，让容器找到最合适的 ip

c.关闭容器

d.替换 v2ray config 中的 ip

e.重启 docker v2ray
