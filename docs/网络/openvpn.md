# openvpn server
## 官方参考文档
    https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md
    https://github.com/kylemanna/docker-openvpn
## 应用场景,机房网络打通
此部署文档只是用于linux 服务器，客户端也是基于命令行，点对点 打通星形网络。mac windows 安卓手机客户端原则也通用
配置文件参数可以复用

## 启动openvpn 

新建docker-compose

    mkdir /data/service/openvpn01 -p
    cd /data/service/openvpn01 
    sudo tee -a ./docker-compose.yml <<-'EOF'
    version: '2'
    services:
      openvpn01:
        cap_add:
         - NET_ADMIN
        image: kylemanna/openvpn
        container_name: openvpn01
        ports:
         - "1194:1194/tcp"
        restart: always
        volumes:
         - ./conf:/etc/openvpn
        EOF

初始化默认文件 默认vpn网段192.168.255.0/24,udp 协议 (有些网络会禁用)

    docker-compose run --rm openvpn01 ovpn_genconfig -u  udp://vpn01.localhost.com 
    
初始化专有配置文件，使用tcp端口， 客户端网段 10.9.11.0/24（tcp 域名可以修改）

    docker-compose run --rm openvpn01 ovpn_genconfig -u  tcp://vpn01.localhost.com  -s 10.9.11.0/24

>  初始化参数可以参考官网

初始化ca证书  

    docker-compose run --rm openvpn01 ovpn_initpki 
    
* Enter New CA Key Passphrase:       密码
* Re-Enter New CA Key Passphrase: 密码
* 接着需要输入常用名（Common Name），直接回车
* Enter pass phrase for /etc/openvpn/pki/private/ca.key: 密码
* Enter pass phrase for /etc/openvpn/pki/private/ca.key: 密码

> 人工交互 一共5次，前两次与后两次 需要输入ca 密码 ，第三次可以为空

## 账号的创建

新建账号username

    docker-compose run --rm openvpn easyrsa build-client-full username nopass

提示 下面 输入 ca 密码

    Enter pass phrase for /etc/openvpn/pki/private/ca.key:  上面设置的ca 密码

获取客户端配置文件 
   
    docker-compose run --rm openvpn ovpn_getclient username > username.ovpn

## 服务端配置参数
###  配置文件 
* 配置位置
    *  对应docker-compose 挂载目录  ./conf/openvpn.conf 
*  duplicate-cn 
    *  功能说明：客户端可以复用证书
    *  应用场景：多客户端复用一个证书，常用于服务器共享出口网关
*  client-to-client 
    * 客户端可以相互访问，为了安全可以不开启  
*  client-config-dir ccd 
    * 功能服务:推送固定ip给客户端
    * 配置方法
        * 在配置目录下新建 ccd 目录
        * 在ccd 目录下 新建用户同名文件
        * ip 配置时是成对出现参考 下列数组
        
ip 列表
        
    [  1,  2] [  5,  6] [  9, 10] [ 13, 14] [ 17, 18]
    [ 21, 22] [ 25, 26] [ 29, 30] [ 33, 34] [ 37, 38]
    [ 41, 42] [ 45, 46] [ 49, 50] [ 53, 54] [ 57, 58]
    [ 61, 62] [ 65, 66] [ 69, 70] [ 73, 74] [ 77, 78]
    [ 81, 82] [ 85, 86] [ 89, 90] [ 93, 94] [ 97, 98]
    [101,102] [105,106] [109,110] [113,114] [117,118]
    [121,122] [125,126] [129,130] [133,134] [137,138]
    [141,142] [145,146] [149,150] [153,154] [157,158]
    [161,162] [165,166] [169,170] [173,174] [177,178]
    [181,182] [185,186] [189,190] [193,194] [197,198]
    [201,202] [205,206] [209,210] [213,214] [217,218]
    [221,222] [225,226] [229,230] [233,234] [237,238]
    [241,242] [245,246] [249,250] [253,254]

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Project layout



    mkdocs.yml    # The configuration file.
    
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.

