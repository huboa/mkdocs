# tee

## 追加新建文件
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
    "data-root": "/data/docker" }
    EOF
> json内容创建，并且支持sudo 提权 添加
