# openvpn-auth-ldap
### 官方参考文档
    https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md
    https://github.com/kylemanna/docker-openvpn
### 应用场景，需要用ldap 管理vpn 账户
### 订制镜像
1. 官方镜像使用的谷歌认证需要重新编辑docker镜像
2. 下载工程 https://github.com/kylemanna/docker-openvpn
3. 编译：
 
修改Dockerfile  添加   openvpn-auth-ldap 插件
   
    RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
        apk add --update openvpn iptables bash easy-rsa  openvpn-auth-ldap openvpn-auth-pam google-authenticator pamtester libqrencode && \
        ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
        rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*
进入dockerfile 目录

    docker build -t locahost-openvpn:1.1 .

### 初始化服务参考readme.md
### 配置ldap 插件
服务端配置添加ldap 认证（必须）

    cd /data/service/openvpn01
    sudo tee -a ./conf/openvpn.conf <<-'EOF'
    plugin /usr/lib/openvpn/plugins/openvpn-auth-ldap.so  "/etc/openvpn/ldap.conf cn=%u"
    EOF

### 启动服务参考readme.md
### 创建用户参考readme.md

## 客户端配置
下载 创建好的配置文件.
创建完证书用户后需要检查下列参数，不存在需要添加

    client   #指定客户端  
    nobind   #不绑定
    dev tun  #指定tun 隧道
    remote-cert-tls server  # tls 证书
    remote vpn01.localhost.com 1194 tcp   #vpn 服务器 地址及端口
    auth-user-pass  #开启密码认证 （必须）
    
### 客户端下载启动
目前 测试过包括 苹果 os  windows 安卓皆可用

### 客户端导入配置文件启动(略)


