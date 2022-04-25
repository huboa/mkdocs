# 集群管理
## 标签
    kubectl label  node   hostname  netenv=outside
##  固定命名空间到某台主机
    kubectl label  node zcb-qas-k8s-node182  uat02-key-zone=uat02    
    kubectl label  node zcb-qas-k8s-node182  uat03-key-zone=uat03    

## docker
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
> json内容创建，并且支持sudo 提权 添加
