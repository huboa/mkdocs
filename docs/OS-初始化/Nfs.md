# CentOS

### 安装命令
    yum nfs-utils -y
## NFS服务端 配置 
### 添加客户端访问用户 
    useradd nfsnobody -s /sbin/nologin -M
### 新建共享文件修改权限
    mkdir /data
    chown -R nfsnobody /data
### 查看
    cat /etc/exports
    /data  192.168.1.0/24(rw,sync,all_squash)    
### 两种方法加载配置文件(平滑启动)
    exportfs -rv
    systemctl reload nfs
### 查看服务器本机共享目录
    showmount -e 127.0.0.1

## 客户端挂载
    /etc/fstab
    192.168.100.102:/data/data/images /usr/local/images  nfs   defaults
    mount -a

