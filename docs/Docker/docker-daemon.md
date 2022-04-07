# daemon.json

## 守护进程配置
### 配置模板

```sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
"log-driver":"json-file",
"log-opts": {"max-size":"100m", "max-file":"3"},
"registry-mirrors": ["https://i3khnsz8.mirror.aliyuncs.com"],
"storage-driver": "overlay2",
"storage-opts": [
"overlay2.override_kernel_check=true"
],
"data-root": "/data/docker-root",
"exec-opts": ["native.cgroupdriver=systemd"],
"default-address-pools": [
    {
      "scope": "local",
      "base": "10.1.8.0/16",
      "size": 24
    }
  ]
 }
EOF
```
### 更新配置后重新启动
    sudo systemctl daemon-reload 
    sudo systemctl restart docker

### 配置桥接默认网络

    "default-address-pools": [
        {
          "scope": "local",
          "base": "172.80.0.0/16",
          "size": 24
        }
      ]
