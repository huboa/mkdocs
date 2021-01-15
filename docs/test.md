# 全量配置
## 智屏互联 v1.0 版

## 1. 目标和原则
* QA同学，可以通过此文档，任意测试环境独立完成产品验收
* 减少配置项，保证生产服务稳定
* 经常变更的配置项，需要发布代码，带来的系统不稳定
* 为了方便管理，除数据库配置其它都可以入库
* 模块不能访问公网，除个别模块 ，减少 502风险
* 出公网需要标明
* 类型分为 job h5 web api 管理 

## 配置文件01

### 2.1  服务模块 abtvsp-api
#### 模块描述

* 模块名称:：abtvsp-api
* 负责人：叶剑飞
* 模块类型：api 
* 提供公网接口服务
* 提供内部集群接口服务
* abtvsp-api 模块为盒子提供接口服务包含自服务TV业务

#### 依赖服务及模块
* mysql 5.x
* redis 4.x
* 鉴黄服务,分词服务
* 需要访问公网服务 www.baidu.com
* 需要访问集群内部模块-sync-api,acs-api,abtvsp-h5(已弃用) 模块

#### 配置文件 config.php
* 配置文件描述 ：自服务计划任务配置文件
* 配置文件路径：/usr/local/nginx/html/script/config.php
<details>                       
<summary>config.php</summary> 
    
```
//PHP起始标记
define('API_HOST', 'http://abtvsp-api');  //对内
//PHP结束标记
```
</details>

#### 配置文件 db-wat.php 
* 配置文件描述 ：微信小程序配置文件
* 配置文件路径：/usr/local/nginx/html/Application/Wat/Conf/db.php
<details>                       
<summary>config.php</summary> 

```
    //PHP起始标记
    <?php

    ///usr/local/nginx/html/Application/Wat/Conf/db.php

    define('DB_TYPE', 'mysql');
    define('DB_HOST', '10.10.10.121');
    define('DB_NAME', 'smart');
    define('DB_USER', 'root');
    define('DB_PWD', '123.com');
    define('DB_PORT', '3306');
    define('DB_PREFIX', 'smart_');
    define('REDIS_HOST', '10.10.10.121');
    define('REDIS_PORT', '6381');
    define('REDIS_AUTH', '');
    define('SESSION_EXPIRE', '900');   
    //*******外网访问*******
    /*主域名*/
    define('URL_HOST', 'http://abtvsp-api-test01.sllhtv.com:50080'); 
    /* 小程序 支付回调*/
    define('WX_NOTIFY_URI', 'http://abtvsp-api-test01.sllhtv.com:50080/Wat/Pay/notify');   
    //*******内网访问*******
    /*融合平台获取*/
    define('YST_URL', 'http://sync-api/yst_syncProject/');
    /*影音 mac 获取项目id */
    define('SMART_HOST', 'http://sync-api/smart_syncProject/'); 
    /*对账平台地址*/
    define('ACS_HOST', 'http://acs-web');  
    //PHP结束标记
```
</details>
#### 配置文件 db.php 
* 配置文件描述 ：配置文件
* 配置文件路径：/usr/local/nginx/html/Application/Api/Conf/db.php
<details>
<summary>db.php</summary>

```
//PHP起始标记
// */usr/local/nginx/html/Application/Api/Conf
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.121');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'business_');   
define('REDIS_HOST', '10.10.10.121');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
define('CASH_HOSTS', 'http://acs-web');//对账平台地址 程序
define('AI_SERVER_HOST', 'http://10.10.10.109:5000');  //图片AI审核服务域名地址
define('SWCS_SERVER_HOST', 'http://10.10.10.109:2011');//分词服务域名地址
// 主域名
define('URL_HOST', 'http://abtvsp-api-test01.sllhtv.com:50080'); //终端
//网关启动图
define('GATEWAY_HOST', 'http://andtvsp-h5-test01.sllhtv.com:50080');//和服务平台地址
define('N_HOST', 'http://112.13.96.202:10081');//N+接口地址
define('GATEWAY_API', 'http://abtvsp-api');//和服务平台接口地址
define('ONEMALL_URL', 'http://onemall');//onemall
//网关启动图状态
define('GATEWAY_DRAFT',1);//草稿
define('GATEWAY_PLAN_ONLINE',2);//计划上线
define('GATEWAY_ONLINE',3);//上线
define('GATEWAY_OFFLINE',4);//下线
define('GATEWAY_CANCEL_ONLINE',5);//取消上线
//网关系统图审核状态
define('GATEWAY_BE_AUDITED',0);//待审核
define('GATEWAY_AUDIT_SUCCESS',1);//审核成功
define('GATEWAY_AUDIT_REJECTION',2);//审核驳回
define('GATEWAY_AUDIT_IN_PROGRESS',3);//审核中
define('GATEWAY_DEFAULT_IMAGE_HOST','http://a.iap.ftp.sllhtv.com:50080/');//网关启动图默认图地址
define('PLATFORM_IDENTIFICATION','center');//cdn 分省标识
//移动认证API接口 appid appkey
define('APP_TOKEN_API','https://wap.cmpassport.com:8443/uniapi/uniTokenValidate');
define('APP_ID','e0d4a41b33d646aeb9f637581fe8b41a');
define('APP_KEY','69263c26a60f453b81d1bb3f3563a408');
//v2接口redis
define('REDIS_HOST_V2', '10.10.10.121');
define('REDIS_PORT_V2', '16381');
define('REDIS_AUTH_V2', '');
define('IS_USE_V2_REDIS', true);//是否使用v2Redis
define("YST_HOST","http://yst-order-sync-api-test01.sllhtv.com:50080/");//易视腾退款接口
//PHP结束标记
```

</details>









