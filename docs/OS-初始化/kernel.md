
### docker
    见docker-daemon.md

### 内核优化说明
    #该参数设置系统的TIME_WAIT的数量，如果超过默认值则会被立即清除
    net.ipv4.tcp_max_tw_buckets = 20000
    #定义了系统中每一个端口最大的监听队列的长度，这是个全局的参数
    net.core.somaxconn = 65535
    #对于还未获得对方确认的连接请求，可保存在队列中的最大数目
    net.ipv4.tcp_max_syn_backlog = 262144
    #在每个网络接口接收数据包的速率比内核处理这些包的速率快时，允许送到队列的数据包的最大数目
    net.core.netdev_max_backlog = 30000
    #此选项会导致处于NAT网络的客户端超时，建议为0。Linux从4.12内核开始移除了 tcp_tw_recycle 配置，如果报错"No such file or directory"请忽略
    net.ipv4.tcp_tw_recycle = 0
    #系统所有进程一共可以打开的文件数量
    fs.file-max = 6815744
    #防火墙跟踪表的大小。注意：如果防火墙没开则会提示error: "net.netfilter.nf_conntrack_max" is an unknown key，忽略即可
    net.netfilter.nf_conntrack_max = 2621440
    ##
    fs.aio-max-nr=1065535

## 最大进程数
    查看最大进程数 
    sysctl kernel.pid_max

    查看所有进程数
    ps -eLf | wc -l
    
    快速更改进程数
    echo 1000000 > /proc/sys/kernel/pid_max
    echo "kernel.pid_max=1000000 " >> /etc/sysctl.conf
    永久配置
    echo "kernel.pid_max=1000000 " >> /etc/sysctl.conf
    sysctl -p

### 内核优化快速执行
    sudo tee -a /etc/sysctl.conf <<EOF
    net.ipv4.tcp_max_tw_buckets = 20000
    net.core.somaxconn = 65535
    net.ipv4.tcp_max_syn_backlog = 262144
    net.core.netdev_max_backlog = 30000
    net.ipv4.tcp_tw_recycle = 0
    fs.file-max = 6815744
    net.netfilter.nf_conntrack_max = 2621440
    EOF
    sysctl -p



