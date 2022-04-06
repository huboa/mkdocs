# CentOS

### 安装命令
    yum install lrzsz net-tools vim repe-release yum-utils bash-completion  wget tree  ntpdate -y
###时间同步
    sudo tee /etc/crontab <<EOF
    */10 * * * * root /usr/sbin/ntpdate ntp1.aliyun.com >/dev/null  2>&1
    EOF

### docker
    yum device-mapper-persistent-data
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum install docker
### 单行
    echo 内容 |sudo tee  /data/logs.txt
> 普通用户可以追加日志
### json
    sudo tee /etc/docker/daemon.json <<EOF
    { "registry-mirrors": ["https://i3khnsz8.mirror.aliyuncs.com"],
    "storage-driver": "overlay2",
    "storage-opts": [
    "overlay2.override_kernel_check=true"
    ],
     "default-address-pools": [
    {
      "scope": "local",
      "base": "10.1.8.0/16",
      "size": 24
    }
    ],
    "data-root": "/data/docker-root" }
    EOF
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


### 内核优化
    sudo tee /etc/docker/daemon.json <<EOF
    net.ipv4.tcp_max_tw_buckets = 20000
    net.core.somaxconn = 65535
    net.ipv4.tcp_max_syn_backlog = 262144
    net.core.netdev_max_backlog = 30000
    net.ipv4.tcp_tw_recycle = 0
    fs.file-max = 6815744
    net.netfilter.nf_conntrack_max = 2621440
    EOF



