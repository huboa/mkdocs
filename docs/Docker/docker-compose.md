# Docker-compose


##  安装
### 二进制
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
> 提示：linux 系统 安装 1.27.4
### 查看版本  
    docker-compose --version
    docker-compose version 1.27.4, build 1110ad01
    
> 提示：安装最新版本请查看 [官网](https://docs.docker.com/compose/install/)

## 配置运行
### 配置docker-compose 运行文件
    sudo mkdir -p /data
    sudo tee /data/docker-compose.yaml <<-'EOF'
    version: "3"
    services:
      nginx:
        image: nginx
        restart: always
        ports:
          - "80:80"
        volumes:
          - /data:/data
        container_name: "nginx"
    EOF
>使用nginx镜像 
    
### 启动容器
    cd /data/ && docker-compose up -d 

### 查看容器状态
    cd /data/ && docker-compose ps
```   
Name               Command               State         Ports
-------------------------------------------------------------------
nginx   /docker-entrypoint.sh ngin ...   Up      0.0.0.0:80->80/tcp
``` 
>运行结果

