#mysql

## 快速部署服务
### 部署环境
系统：[centos7]()  
运行环境：[docker](../Docker/docker.md)  
容器管理：[dockercompose](../Docker/docker-compose.md) 
>点击查看安装文档

### 配置
####  docker-compose.yml
```
sudo mkdir /data
sudo tee /data/docker-compose.yml <<EOF
version: "3"
services:
  mysql01:
    container_name: "mysql01"
    restart: always
    volumes:
      - /data/mysql01/data:/var/lib/mysql
      - /data/mysql01/conf/my.cnf:/etc/my.cnf
    image: mysql:5.7
    environment:
      - MYSQL_ROOT_PASSWORD=123.com
      - TZ=Asia/Shanghai
    ports:
      - "3306:3306"
EOF 
```
####  my.cnf
```
sudo mkdir -p /data/mysql01/{conf,data}
sudo tee /data/mysql01/conf/my.cnf <<EOF
[client]
[mysqld]
port = 3306   #设置3306端口
datadir=/var/lib/mysql  # 数据的存放目录 
[mysqldump]
EOF
``` 
> 最简配置 部署
> 定制配置 直接修改my.cnf 启动

### 服务管理
#### 启动
    cd /data/ 
    docker-compose up -d mysql01
    docker-compose ps 
#### 重启和停止
    docker-compose stop mysql01
    docker-compose restart mysql01
#### 初次登录
    docker exec -it mysql01 bash 
    mysql -uroot -p 
> 密码123.com 

#### 创建管理员
    grant all on *.* to 'root'@'%' identified by '123.com';
    select user,host from mysql.user;

#### 查询配置变量
    show variables like '%slow%';
> %%为通配符，slow是过滤的内容 ,查询慢查询  
> 修改配置 my.cnf [详细配置]()  重启容器生效
#### 重置服务
    docker-compose down 
    rm -rf /data/mysql01
> 部署完成

---
## 详细配置
###my.conf 模板

<details>
<summary>点击查看</summary>  
<pre><code>
```
    [client]
    user = root
    host = localhost
    password = 123.com  
    [mysql]
    # 设置mysql客户端默认字符集
    default-character-set=utf8
    socket=/var/run/mysqld/mysqld.sock
    [mysqld]
    #skip-grant-tables
    skip-name-resolve
    #设置3306端口
    port = 3306
    #sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
    ##设置日志时间戳
    log_timestamps=SYSTEM
    # 设置mysql的安装目录
    #basedir=/var/lib/mysql
    # 设置mysql数据库的数据的存放目录
    datadir=/var/lib/mysql
    #MySQL连接数
    max_connections=4000
    max_connect_errors=6000
    #wait_timeout=600
    #interactive_timeout=10
    #MySQL打开的文件描述符限制
    open_files_limit=65535
    # 服务端使用的字符集默认为8比特编码的latin1字符集
    character-set-server=utf8
    # 创建新表时将使用的默认存储引擎
    default-storage-engine=INNODB
    #lower_case_table_name=1
    max_allowed_packet=100M
    key_buffer_size=32MB
    # innodb参数
    innodb_buffer_pool_size=512M
    innodb_buffer_pool_dump_at_shutdown=1  #该命令用于在关闭时把热数据dump到本地磁盘
    innodb_buffer_pool_load_at_startup=1   #在启动时把热数据加载到内存
    innodb_flush_log_at_trx_commit=0  #每个事务提交时。每隔一秒，把事务日志缓冲区的数据写到日志文件中，以及吧日志文件的数据刷到磁盘上他的性能是最好的，同样安全性也是最差的，当系统宕机时，会丢失1秒的数据
    #避免双写缓冲的参数：
    innodb_flush_method=O_DIRECT
    innodb_lock_wait_timeout=50 # 锁等待超时时间 单位秒
    #启用标准InnoDB监视器
    #innodb_status_output=ON
    # 查询缓存
    query_cache_size=56MB
    query_cache_type=0
    #慢查询：
    #开启慢查询日志：
    slow_query_log=1
    slow_query_log_file=mysql_slow.log
    long_query_time=2
    #配置错误日志：
    log-error=/var/lib/mysql/mysql_error.log
    #访问日志
    general_log=on
    general_log_file=/var/lib/mysql/mysql_general.log
    # 复制的参数
    log_bin=master-bin
    server_id=10
    binlog_format=ROW
    sync_binlog=1
    # 半同步复制参数
    #rpl_semi_sync_master_enabled = 1
    #rpl_semi_sync_master_timeout = 1000 # 单位秒
    #sql-mode=ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
    #sql-mode=ONLY_FULL_GROUP_BY,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
    sql_mode=NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
    # 启用gtid复制：
    #gtid_mode=ON
    #enforce-gtid-consistency=true
</code></pre>
</details>

### 时间戳
#### 时区
##### 查看
    show variables like '%zone%';
##### 永久配置
    [mysqld]
    log_timestamps=SYSTEM
##### 临时配置
    
#### 日期时间
##### 查看格式
    select now();
    show variables like '%date_format%';
    show variables like '%time_format%';
    show variables like '%datetime_format%';

### 日志
#### 日志类型
* 二进制日志：该日志文件会以二进制的形式记录数据库的各种操作，但不记录查询语句。
* 错误日志：该日志文件会记录 MySQL 服务器的启动、关闭和运行错误等信息。
* 通用查询日志：该日志记录 MySQL 服务器的启动和关闭信息、客户端的连接信息、更新、查询数据记录的 SQL 语句等。
* 慢查询日志：记录执行事件超过指定时间的操作，通过工具分析慢查询日志可以定位 MySQL 服务器性能瓶颈所在。
#### 慢日志
##### 参数：
    slow_query_log          ON/OFF      开启、关闭  
    long_query_time         n           时间参数单位秒
    slow_query_log_file     /dir/file   慢查询日志记录文件
##### 查看状态
    show variables like 'slow_query_log%';
    show variables like 'long_query_time';
##### 临时开启
    set global slow_query_log=ON;
    set global slow_query_log_file=mysql_slow.log
    set global long_query_time=1;
##### 永久开启
    [mysqld]
    slow_query_log=ON
    slow_query_log_file=mysql_slow.log
    long_query_time=1
> 超过2秒 记录慢查询

#### 查询日志
##### 参数：
    general_log         ON/OFF      开启、关闭  
    general_log_file    /dir/mysql_general.log ##日志路径
##### 查看状态
    show variables like 'general_log%';
##### 临时开启
    set global general_log=ON;
    set global general_log_file=mysql_slow.log
##### 永久开启
    [mysqld]
    general_log=ON
    general_log_file=mysql_general.log

#### 错误日志
##### 参数：
    log_error_verbosity     n                    ##日志3个级别
    log-error             /dir/mysql_error.log   ##日志路径

> 日志级别：  
> 1.Error  
> 2.Error and warning        
> 3.Error, warning, and note messages
##### 查看状态
    show variables like 'log_error%';
##### 默认开启
    set global log_error_verbosity=3;
    set global log-error=mysql_error.log;
##### 永久开启
    [mysqld]
    log_error_verbosity=3
    log-error=mysql_error.log
#### binlog 日志

## 用户管理
    mysql -uroot -p -h127.0.0.1 -P3306 
> -u 用户
> -p 密码
> -h 主机
> -P 端口

## 库
### 新建
    CREATE DATABASE yearning_pro CHARACTER SET utf8 COLLATE utf8_general_ci;
    show create database qiyue;
>新建名称为 qiyue  的数据库,查询sql语句
### 查看
    show databases; 
    show databases like '%qiyue%';
    use  qiyue;   
> 查询数据库库名为qi月的数据库，进入qiyue数据库

## 表
### 新建
    略
### 查看
    show tables;
    desc user;
    
>查看全部表，查看单个表结构
### 查看当执行的语句
    show processlist;
> 查找问题
> 
### 创建账号
    grant all on *.* to 'yearning_pro'@'%' identified by 'QJQIqHQJQIqDFEDFH';

