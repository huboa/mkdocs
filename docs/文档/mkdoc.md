# mkdoc


## 快速部署服务
### 部署环境
系统：[centos7]()  
运行环境：[docker](../Docker/docker.md)  
容器管理：[dockercompose](../Docker/docker-compose.md) 
>NOTE：点击查看安装文档

### docker-compose.yml
```
sudo mkdir /data
sudo tee   /data/docker-compose.yml <<EOF
version: "3"
services:
  mkdocs:
    image: squidfunk/mkdocs-material
    container_name: "mkdocs"
    restart: always
    ports:
      - "8088:8000"
    volumes:
      - /data/mkdocs:/docs
EOF 
```
###  修改配置 mkdocs.yml
```
sudo mkdir -p /data/mkdocs
sudo tee  /data/mkdocs/mkdocs.yml <<EOF
site_name: 七月
theme:
  name: material
EOF
``` 

### 创建首页
```
sudo mkdir -p /data/mkdocs/docs
sudo tee  /data/mkdocs/docs/index.md <<EOF
# readme
For full documentation visit [mkdocs.org](https://www.mkdocs.org).
## Commands
* \`mkdocs new [dir-name]\` - Create a new project.
* \`mkdocs serve\` - Start the live-reloading docs server.
* \`mkdocs build\` - Build the documentation site.
* \`mkdocs -h - Print\` help message and exit.
## Project layout
    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.
EOF
```
> 文档存放在 /data/mkdocs/docs
### 启动服务
    cd /data
    sudo docker-compose up -d mkdocs
    sudo docker-compose ps 
### 查看网站
    打开 http://IP:8088 
    


