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

## 2.配置文件


### 2.2  服务模块 abtvsp-job
#### 模块描述

* 模块名称：abtvsp-job
* 负责人：叶剑飞
* 模块类型：job 
* abtvsp-job模块：定时任务(版面,素材,网关启动图鉴黄验证,版面定时上线,网关启动图定时上下线)

#### 依赖服务及模块
* 需要访问集群内部模块-(abtvsp-api)-模块

#### 配置文件 crontab
* 配置文件描述 ：计划任务
* 配置文件路径：

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看crontab</font>
        </mark>
    </summary>
    
<pre><code>

    SHELL=/bin/bash
    PATH=/sbin:/bin:/usr/sbin:/usr/bin
    MAILTO=root
    HOME=/usr/local/nginx/html

    # For details see man 4 crontabs
    
    # Example of job definition:
    # .---------------- minute (0 - 59)
    # |  .------------- hour (0 - 23)
    # |  |  .---------- day of month (1 - 31)
    # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
    # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
    # |  |  |  |  |
    # *  *  *  *  * user-name  command to be executed
    * * * * * root /usr/bin/bash /usr/local/nginx/html/script/monitor_self_task.sh  /usr/local/nginx/html
    # 易视腾影音订单更新核对状态接口 十分钟执行一次。
    */10 * * * *  root /usr/bin/php /usr/local/nginx/html/index.php  Api/Script/movieOrder
</code></pre>
</details>

#### 配置文件 config.php
* 配置文件描述 ：计划任务配置文件
* 配置文件路径：/usr/local/nginx/html/script/config.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.php</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('API_HOST', 'http://abtvsp-api');  //对内
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php
* 配置文件描述 ：计划任务配置文件
* 配置文件路径：/usr/local/nginx/html/Application/Api/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php</font>
        </mark>
    </summary>
    <pre><code>  
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
    </code></pre>
</details>


### 2.5  服务模块 analyst-api
#### 模块描述

* 模块名称：analyst-api
* 负责人：叶剑飞
* 模块类型：api 
* analyst-api模块

#### 依赖服务及模块
* MongoDB

#### 配置文件 config.yml
* 配置文件描述 ：配置文件
* 配置文件路径：/var/shulian/config.yml

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.yml</font>
        </mark>
    </summary>
    <pre><code>  
MongoDB:
  host: "10.10.10.109"
  port: 27017
  db_name: "dataprocessor"
    </code></pre>
</details>

### 2.6  服务模块 analyst-job
#### 模块描述

* 模块名称：analyst-job
* 负责人：叶剑飞
* 模块类型：job 
* analyst-job模块

#### 依赖服务及模块
* mysql
* MongoDB
* kafka
* redis

#### 配置文件 config.yml
* 配置文件描述 ：配置文件
* 配置文件路径：/var/shulian/config.yml

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.yml</font>
        </mark>
    </summary>
<pre><code> 
     
    # MySQL 相关配置
    #
    MySQL-Host: '10.10.10.122'
    MySQL-Port: 3306
    MySQL-Username: 'root'
    MySQL-Password: '123.com'
    MySQL-Database: 'smart'
    
    
    # MongoDB 相关配置
    #
    MongoDB-Host: '10.10.10.122'
    MongoDB-Port: 27017
    #MongoDB-Username: 'user'
    #MongoDB-Password: 'user123'
    
    # Kafka 相关配置
    #
    Kafka-Host: '10.10.10.109'
    Kafka-Port: 9092
    
    
    # Redis 相关配置
    #
    Redis-Host: '10.10.10.122'
    Redis-Port: 6381
    #Redis-Password: 'abc123'
    
    
</code></pre>
</details>

### 2.7  服务模块 andtvsp-h5
#### 模块描述

* 模块名称：andtvsp-h5
* 负责人：李航飞
* 模块类型：h5 
* andtvsp-h5模块

#### 依赖服务及模块


#### 配置文件 index.js
* 配置文件描述 ：自服务前端配置文件
* 配置文件路径：/var/shulian/config/index.js 

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看index.js</font>
        </mark>
    </summary>
    <pre><code>  
var host = 'http://abtvsp-api-pre01.sllhtv.com:50080'
    </code></pre>
</details>

### 2.8  服务模块 andtvsp-m-h5
#### 模块描述

* 模块名称：andtvsp-m-h5
* 负责人：李航飞
* 模块类型：h5 
* andtvsp-m-h5模块

#### 依赖服务及模块


#### 配置文件 index.js
* 配置文件描述 ：和办公H5配置文件
* 配置文件路径：/var/shulian/config/index.js 

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看index.js</font>
        </mark>
    </summary>
    <pre><code>  
var host = 'http://abtvsp-api-pre01.sllhtv.com:50080'
    </code></pre>
</details>

### 2.9  服务模块 appmanager-web
#### 模块描述

* 模块名称：appmanager-web
* 负责人：叶剑飞
* 模块类型：web
* appmanager-web模块

#### 依赖服务及模块
* mysql
* redis
* 需要访问集群内部模块-smart-api-模块

#### 配置文件 db.php-appmanager
* 配置文件描述 ：应用市场配置文件
* 配置文件路径：/usr/local/nginx/html/Application/AppManager/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-appmanager</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//mysql配置
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'slams');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'slams_');

//redis配置
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');

// 主域名
define('URL_HOST', 'http://appmanager-web-pre01.sllhtv.com:50080');
// 支持服务器自访问的地址
define('SELF_HOST', '');

// 米花推送服务开关
define('MIHUA_SERVER', false);

//短信网关
define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
//PHP结束标记
    </code></pre>
</details>



### 2.12  服务模块 dsmart-web
#### 模块描述

* 模块名称：dsmart-web
* 负责人：叶剑飞
* 模块类型：web
* dsmart-web模块

#### 依赖服务及模块
* mysql
* redis
* Ftp
* 依赖模块:dsmart-api,weather-api,assistant-api,cms-web,sync-api,paycenter-api,videopay-h5,abtvsp-api

#### 配置文件 config.app.php
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/app/config.app.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.app.php</font>
        </mark>
    </summary>
    <pre><code>
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'slams');
define('DB_USER', 'root');
define('DB_PASS', '123.com');
define('DB_PORT', '3306');
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 config.inc.php
  * 配置文件描述 ：终端接口配置文件
  * 配置文件路径：/usr/local/nginx/html/config.inc.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.inc.php</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PASS', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');

define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('REDIS_EXPIRE','');
define('SESSION_EXPIRE', '900');

//C3-redis
define('REDIS_HOST_C3', '10.10.10.122');
define('REDIS_PORT_C3', '6381');
define('REDIS_AUTH_C3', '');
define('REDIS_EXPIRE_C3','');
define('SESSION_EXPIRE_C3', '900');

// 主域名
define('API_HOST', '');  //终端访问

// 消息接口访问消息页面地址
define('MESSAGE_URL', '/Api/ShowMessage/message/id/');   //终端访问

// 写日志文件路径
define('LOG_DIR','/data/iap-log');
//党建开机、心跳上报IP
define('SEND_IP','');
//党建开机、心跳上报端口
define('SEND_PORT','');

//往中心写库接口服务器域名,apk升级需要向中心更新设备的升级的版本 和升级的时间
define('WRITE_API_SERVER', 'http://smart-api/');    //程序访问

//ftp 存放本地欢迎语合成图片
define('SERVER', '');//ftp服务器ip
define('ACCOUNT', '');//ftp账号
define('PASSWORD', '');//账号密码
define('PORT', '');//端口
define('PASV', '0');//主被动模式
define('SSL', '0');//ssl连接,默认不开启
define('TIMEOUT', '30');//超时时间,默认60,单位 s
define('PATH', '/');//存储根目录
// kafka 配置

define('KAFKA_HOSTS', '10.10.10.109:2181');//zookeeper 方式
define('KAFKA_TOPIC', 'origin');//topic 
define('KAFKA_GROUP', 'test-consumer-group');//group id


// 天气接口-供页面调用
define('WEATHER_PAGE','http://weather-api/WeatherApi?citykey=');    //程序访问
// 要获得天气接口的数据
define('WEATHER_SWITCH_URL','http://wthrcdn.etouch.cn/weather_mini?city=');    //程序访问
// 页面地址
define('API_WEATHER_URL','http://localhost/api_weather.php?action=launcherInfo&');    //本地自访问  程序访问
// 天气接口数据缓存时间
define('WEATHER_PAGE_DEADLINE','7200');
// 状态栏天气接口缓存有效期300秒
define('STATUS_BAR_DEADLINE','7200');
// 内容页面缓存有效期300 秒
define('CONTENTPAGE_DEADLINE','86400');
// 导航页面缓存有效期300 秒
define('NAVPAGE_DEADLINE','86400');
// 启动图页面缓存有效期300 秒
define('OPENMATERIAL_DEADLINE','86400');

/*eds鉴权接口地址*/
$edsList = array(
    'sxcm_iap_ott' => array(
        '华为' => 'http://111.20.33.15:8082',
        '中兴' => 'http://111.20.105.85:9330',
    )
);

//平台标识
define('PLATFORM_IDENTIFICATION','center');

//PHP结束标记
    </code></pre>
</details>

#### 配置文件 config.php
  * 配置文件描述 ：平台版面预览配置文件
  * 配置文件路径：/usr/local/nginx/html/api/config.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.php</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
// 主要用于版面预览，必须保证填写的域名可以支持服务器自访问
define('SERVER','http://smart-api/');  //程序访问
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-api
  * 配置文件描述 ：终端接口配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Api/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-api</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//mysql配置
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
//redis配置
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
//redis连接超时时间
define('REDIS_TIMEOUT',3);
<br/>
define('APPID', 'wx6e60f9972052c406');//小程序AppID
define('APPSERVER', '3d98750fe0fec83a015bc973b23566c9');//小程序Server
define('WXCODE', 'http://assistant-api');//H5 地址  终端访问
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-appmanager
  * 配置文件描述 ：应用市场配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/AppManager/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-appmanager</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//数据库配置
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'slams');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'slams_');
//redis配置 
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
<br/>
// 主域名
define('URL_HOST', 'https://smart-adm-web-pre01.sllhtv.com:50443');  //终端访问
// 支持服务器自访问的地址
define('SELF_HOST', 'http://smart-api/');   //程序访问
// 米花推送服务开关
define('MIHUA_SERVER', false);
<br/>
define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-movie
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Movie/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-movie</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
<br/>
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
<br/>
// 主域名
define('URL_HOST', 'http://smart-adm-web-pre01.sllhtv.com:50080');   //终端访问
<br/>
// 媒资管理系统地址，用于影音服务调取媒资系统接口
define('MEIZIOTT_URL', 'http://cms-web');    //程序访问
<br/>
//融合平台sn获取项目详情
define('YST_URL', 'http://sync-api/yst_syncProject/');  //程序访问
<br/>
//智能桌面mac获取项目详情
define('SMART_HOST', 'http://sync-api/smart_syncProject/');   //程序访问
<br/>
//支付地址
define('API_URL', 'http://paycenter-api');    //程序访问
<br/>
//对账地址
define('ACS_URL', 'http://acs-web');   //程序访问
<br/>
//付费影音H5地址
define('H5_URL', 'http://videopay-h5-pre01.sllhtv.com:50080');   //终端访问
<br/>
define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
define('APP_ID', 'wx306ec33baa8025e7');
define('SECRET', '00fe04addd7eddf0048d4e532351de8d');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
define('APP_ID', 'wxaddbbb291b9539d7');
define('SECRET', '76f16722dc57d0c9ff39a6026a9a36c4');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-smart
  * 配置文件描述 ：智能桌面配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Smart/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-smart</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
<br/>
define('ORDER_SYNC_RETURN', 'http://112.35.86.168:8090/onemallExchange/OpenService/acceptOrderResult');  //程序访问
define('ORDER_SYNC_LOG', '/data/onemall/log/orderSync.log');
define('ARCHIVE_SYNC_LOG', '/data/onemall/log/archiveSync.log');
define('ORDER_SYNC_RETURN_LOG', '/data/onemall/log/orderSyncReturn.log');
define('MEMBER_FTP_SERVER', '192.168.10.5');
define('MEMBER_FTP_USERNAME', 'hetv_online');
define('MEMBER_FTP_PASSWORD', 'Ftp@Online_456');
define('MEMBER_FTP_PORT', '50021');
define('MEMBER_FTP_PASV', true);
define('MEMBER_FTP_SSL', false);
define('MEMBER_FTP_TIMEOUT', 60);
define('MEMBER_FTP_IN', '/in');
define('MEMBER_FTP_OUT', '/out');
define('MEMBER_FTP_FILE_IN', '/data/onemall/in');
define('MEMBER_FTP_FILE_OUT', '/data/onemall/out');
define('MEMBER_FTP_FILE_LOCAL', '/callback');//反馈报文本地地址（目前只有咪咕使用）
<br/>
define('CMS_LOGIN_URL','http://cms-web/Qwadmin/CommonLogin/login?token=');    //程序访问
<br/>
// 主域名
define('URL_HOST', '');   //浏览器后台管理员访问
// 媒资管理系统地址，用于影音服务调取媒资系统接口
define('MEIZIOTT_URL', 'http://cms-web/');     //程序访问
// 敏感词域名
define('SENSITIVE_WORDS_HOST', 'http://abtvsp-api/');   //程序访问
/*对账域名*/
define('CASH_HOSTS', 'http://acs-web/');   //程序访问
<br/>
//平台标识
define('PLATFORM_IDENTIFICATION','center');
//onemall存量项目绑定默认版面处理接口地址
define('ONEMALL_DEFAULT_LAYOUT_SET_URL', 'http://onemall-api/Interfaces/StockDeal/addDefaultLayout');  //程序访问
<br/>
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
<br/>
define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
define('APP_ID', 'wx306ec33baa8025e7');
define('SECRET', '00fe04addd7eddf0048d4e532351de8d');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
define('APP_ID', 'wxaddbbb291b9539d7');
define('SECRET', '76f16722dc57d0c9ff39a6026a9a36c4');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
<br/>
//网关启动图
define('GATEWEY_URL','http://abtvsp-api/');   //程序访问
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
define('GATEWAY_AUDIT_IN_PROGRESS',3);//审核中*/
//PHP结束标记
    </code></pre>
</details>

### 2.13  服务模块 dsmart-api
#### 模块描述

* 模块名称：dsmart-api
* 负责人：叶剑飞
* 模块类型：web
* dsmart-api模块

#### 依赖服务及模块
* mysql
* redis
* Ftp
* 依赖模块:dsmart-web,weather-api,assistant-api,cms-web,sync-api,paycenter-api,videopay-h5,abtvsp-api

#### 配置文件 config.app.php
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/app/config.app.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.app.php</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'slams');
define('DB_USER', 'root');
define('DB_PASS', '123.com');
define('DB_PORT', '3306');
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 config.inc.php
  * 配置文件描述 ：终端接口配置文件
  * 配置文件路径：/usr/local/nginx/html/config.inc.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.inc.php</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//读数据库配置
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PASS', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');

//写数据库配置
define('WRITE_DB_TYPE', 'mysql');
define('WRITE_DB_HOST', '10.10.10.122');
define('WRITE_DB_NAME', 'smart');
define('WRITE_DB_USER', 'root');
define('WRITE_DB_PASS', '123.com');
define('WRITE_DB_PORT', '3306');
define('WRITE_DB_PREFIX', 'smart_');

//redis 缓存
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('REDIS_EXPIRE','');
define('SESSION_EXPIRE', '900');

//C3-redis
define('REDIS_HOST_C3', '10.10.10.122');
define('REDIS_PORT_C3', '6382');
define('REDIS_AUTH_C3', '');
define('REDIS_EXPIRE_C3','');
define('SESSION_EXPIRE_C3', '900');

// 主域名
define('API_HOST', 'http://smart-api-pre01.sllhtv.com:50080/');

// 消息接口访问消息页面地址
define('MESSAGE_URL', 'http://smart-api-pre01.sllhtv.com:50080/Api/ShowMessage/message/id/');

// 写日志文件路径
define('LOG_DIR','/data/iap-log');
//党建开机、心跳上报IP
define('SEND_IP','');
//党建开机、心跳上报端口
define('SEND_PORT','');

//往中心写库接口服务器域名,apk升级需要向中心更新设备的升级的版本 和升级的时间
define('WRITE_API_SERVER', 'http://smart-api-pre01.sllhtv.com:50080/');

//ftp 存放本地欢迎语合成图片
define('SERVER', '');//ftp服务器ip
define('ACCOUNT', '');//ftp账号
define('PASSWORD', '');//账号密码
define('PORT', '');//端口
define('PASV', '0');//主被动模式
define('SSL', '0');//ssl连接,默认不开启
define('TIMEOUT', '30');//超时时间,默认60,单位 s
define('PATH', '/');//存储根目录
// kafka 配置

define('KAFKA_HOSTS', '10.10.10.109:2181');//zookeeper 方式
define('KAFKA_TOPIC', 'origin');//topic 
define('KAFKA_GROUP', 'test-consumer-group');//group id


// 天气接口-调用内部天气模块API
define('WEATHER_PAGE','http://weather-api/WeatherApi?citykey=');
// 要获得天气接口的数据（已弃用）
define('WEATHER_SWITCH_URL','http://wthrcdn.etouch.cn/weather_mini?city=');
// 页面地址（服务内跳转）
define('API_WEATHER_URL','http://localhost/api_weather.php?action=launcherInfo&');
// 天气接口数据缓存时间
define('WEATHER_PAGE_DEADLINE','300');
// 状态栏天气接口缓存有效期300秒
define('STATUS_BAR_DEADLINE','300');
// 内容页面缓存有效期300 秒
define('CONTENTPAGE_DEADLINE','300');
// 导航页面缓存有效期300 秒
define('NAVPAGE_DEADLINE','300');
// 启动图页面缓存有效期300 秒
define('OPENMATERIAL_DEADLINE','300');
//Mac存入redis 有效期1小时3600
define('MACREDIS_DEADLINE','3600');

/*eds鉴权接口地址*/
$edsList = array(
    'sxcm_iap_ott' => array(
        '华为' => 'http://111.20.33.15:8082',
        '中兴' => 'http://111.20.105.85:9330',
    )
);

//平台标识
define('PLATFORM_IDENTIFICATION','center');

//云酒馆-全通提供
define('APP_SECRETKEY', '0E3FADB6A87B41DEB582909DCD5D03B4');
define('REQUEST_ID', '1');
define('APP_CODE', 'app_01');
//西软授权配置
define('APPKEY_XR', 'SLLHVOD');//西软提供appKey
define('SECRET_XR', 'PsQRsZcu0ATw9PTKsa8');//西软提供secret
define('FIXED_HOTELID_XR', 'G000001');//西软提供固定酒店ID
//业务参数
define('HOTELID_XR', 'H000058');//西软提供业务酒店ID
define('URL_XR', 'http://xop360.test.foxhis.com/xmsopen-web/rest');//西软提供业务接口地址

define("TOKEN_TIME","600");//token过期时间 10分钟

//终端登录计数连接redis超时时间
define('REDIS_TIMEOUT',3);

//监控数据埋点根据user agent判断 内容为正则表达式
$userAgentArray = array(
    '/^okhttp/',
    '/IndustryVersionName/'
);
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 config.inc.php-heart
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/heart/config/config.inc.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.inc.php-heart</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PASS', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
<br/>
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('REDIS_EXPIRE','');
define('SESSION_EXPIRE', '900');
<br/>
//被动接口请求间隔时间,单位分钟
define('PASSIVE_INTERFACE_INTERVAL', 15);
//api_server.php部署的服务器域名地址
define('TIME_SERVER_HOST', '');
//PHP结束标记
    </code></pre>
</details>


#### 配置文件 config.php
  * 配置文件描述 ：平台版面预览配置文件
  * 配置文件路径：/usr/local/nginx/html/api/config.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.php</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
// 主要用于版面预览，必须保证填写的域名可以支持服务器自访问
define('SERVER','http://smart-api/');  //程序访问
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-api
  * 配置文件描述 ：终端接口配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Api/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-api</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//mysql配置
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
//redis配置
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
<br/>
define('APPID', 'wx6e60f9972052c406');//小程序AppID
define('APPSERVER', '3d98750fe0fec83a015bc973b23566c9');//小程序Server
define('WXCODE', 'http://assistant-api');//H5 地址  终端访问
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-appmanager
  * 配置文件描述 ：应用市场配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/AppManager/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-appmanager</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//数据库配置
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'slams');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'slams_');
//redis配置 
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');

// 主域名
define('URL_HOST', 'https://smart-adm-web-pre01.sllhtv.com:50443');  //终端访问
// 支持服务器自访问的地址
define('SELF_HOST', 'http://smart-api/');   //程序访问
// 米花推送服务开关
define('MIHUA_SERVER', false);

define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-movie
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Movie/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-movie</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
<br/>
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
<br/>
// 主域名
define('URL_HOST', 'http://smart-adm-web-pre01.sllhtv.com:50080');   //终端访问
<br/>
// 媒资管理系统地址，用于影音服务调取媒资系统接口
define('MEIZIOTT_URL', 'http://cms-web');    //程序访问
<br/>
//融合平台sn获取项目详情
define('YST_URL', 'http://sync-api/yst_syncProject/');  //程序访问
<br/>
//智能桌面mac获取项目详情
define('SMART_HOST', 'http://sync-api/smart_syncProject/');   //程序访问
<br/>
//支付地址
define('API_URL', 'http://paycenter-api');    //程序访问
<br/>
//对账地址
define('ACS_URL', 'http://acs-web');   //程序访问
<br/>
//付费影音H5地址
define('H5_URL', 'http://videopay-h5-pre01.sllhtv.com:50080');   //终端访问
<br/>
define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
define('APP_ID', 'wx306ec33baa8025e7');
define('SECRET', '00fe04addd7eddf0048d4e532351de8d');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
define('APP_ID', 'wxaddbbb291b9539d7');
define('SECRET', '76f16722dc57d0c9ff39a6026a9a36c4');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-smart
  * 配置文件描述 ：智能桌面配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Smart/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-smart</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
<br/>
define('ORDER_SYNC_RETURN', 'http://112.35.86.168:8090/onemallExchange/OpenService/acceptOrderResult');  //程序访问
define('ORDER_SYNC_LOG', '/data/onemall/log/orderSync.log');
define('ARCHIVE_SYNC_LOG', '/data/onemall/log/archiveSync.log');
define('ORDER_SYNC_RETURN_LOG', '/data/onemall/log/orderSyncReturn.log');
define('MEMBER_FTP_SERVER', '192.168.10.5');
define('MEMBER_FTP_USERNAME', 'hetv_online');
define('MEMBER_FTP_PASSWORD', 'Ftp@Online_456');
define('MEMBER_FTP_PORT', '50021');
define('MEMBER_FTP_PASV', true);
define('MEMBER_FTP_SSL', false);
define('MEMBER_FTP_TIMEOUT', 60);
define('MEMBER_FTP_IN', '/in');
define('MEMBER_FTP_OUT', '/out');
define('MEMBER_FTP_FILE_IN', '/data/onemall/in');
define('MEMBER_FTP_FILE_OUT', '/data/onemall/out');
define('MEMBER_FTP_FILE_LOCAL', '/callback');//反馈报文本地地址（目前只有咪咕使用）
<br/>
define('CMS_LOGIN_URL','http://cms-web/Qwadmin/CommonLogin/login?token=');    //程序访问
<br/>
// 主域名
define('URL_HOST', '');   //浏览器后台管理员访问
// 媒资管理系统地址，用于影音服务调取媒资系统接口
define('MEIZIOTT_URL', 'http://cms-web/');     //程序访问
// 敏感词域名
define('SENSITIVE_WORDS_HOST', 'http://abtvsp-api/');   //程序访问
/*对账域名*/
define('CASH_HOSTS', 'http://acs-web/');   //程序访问
<br/>
//平台标识
define('PLATFORM_IDENTIFICATION','center');
//onemall存量项目绑定默认版面处理接口地址
define('ONEMALL_DEFAULT_LAYOUT_SET_URL', 'http://onemall-api/Interfaces/StockDeal/addDefaultLayout');  //程序访问
<br/>
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
<br/>
define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
define('APP_ID', 'wx306ec33baa8025e7');
define('SECRET', '00fe04addd7eddf0048d4e532351de8d');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
define('APP_ID', 'wxaddbbb291b9539d7');
define('SECRET', '76f16722dc57d0c9ff39a6026a9a36c4');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
<br/>
//网关启动图
define('GATEWEY_URL','http://abtvsp-api/');   //程序访问
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
define('GATEWAY_AUDIT_IN_PROGRESS',3);//审核中*/
//PHP结束标记
    </code></pre>
</details>

### 2.14  服务模块 log-service-api
#### 模块描述

* 模块名称：log-service-api
* 负责人：叶剑飞
* 模块类型：api
* log-service-api模块

#### 依赖服务及模块
* kafka
* 依赖模块:videopay-h5

#### 配置文件 config.inc.php
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/config.inc.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.inc.php</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//kafka
define('KAFKA_HOSTS','10.10.10.109:2181');
define('KAFKA_TOPIC','origin');
define('KAFKA_GROUP','test-consumer-group');

//平台标识
define('PLATFORM_IDENTIFICATION','center');
define("Channel",serialize(
    array( 'yncm_iap_ott'=>"云南政企ott渠道",
    'sd_gitv'=>"山东政企ott渠道",
    'mg_iap'=>"咪咕基地政企ott渠道",
    'ln_iap'=>"辽宁政企ott渠道",
    'cqcm_iap_ott'=>"重庆政企ott渠道",
    'tjcm_iap_iptv'=>"天津政企iptv渠道",
    'hbcm_iap_ott'=>"湖北政企ott渠道",
    'nmcm_iap_iptv'=>"内蒙古政企iptv渠道",
    'sxcm_iap_ott'=>"陕西政企ott渠道",
    'hncm_iap_ott'=>"河南政企ott渠道",
    'sxcm_iap_iptv'=>"山西政企iptv渠道"
    )));
define("SUB_SYSTEM","http://112.33.20.156:6666");//经分域名
define("LOG_ADDRESS","/tmp/sub_error.log");//经分错误日志上传路径

//跨域配置
define("HTTP_ORIGIN",serialize(
    array( "http://videopay-h5-pre01.sllhtv.com:50080"
)));

//PHP结束标记
    </code></pre>
</details>



### 2.17  服务模块 room-h5
#### 模块描述

* 模块名称：room-h5
* 负责人：李航飞
* 模块类型：h5
* room-h5模块

#### 依赖服务及模块
* 依赖模块:abtvsp-api

#### 配置文件 config.js
  * 配置文件描述 ：配置文件
  * 配置文件路径：/var/shulian/js/config.js

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.js</font>
        </mark>
    </summary>
    <pre><code>  
/*接口域名配置*/
//	ajax接口路径
var ajaxUrl = 'http://abtvsp-api-pre01.sllhtv.com:50080/';
    </code></pre>
</details>

### 2.20  服务模块 smart-job
#### 模块描述

* 模块名称：smart-job
* 负责人：叶剑飞
* 模块类型：job
* smart-job模块

#### 依赖服务及模块
* mysql
* redis
* ftp
* 依赖模块:analyst-api,onemall-api,cms-web

#### 配置文件 config.inc.php-heart
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/heart/config/config.inc.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.inc.php-heart</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PASS', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');


define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('REDIS_EXPIRE','');
define('SESSION_EXPIRE', '900');

//被动接口请求间隔时间,单位分钟
define('PASSIVE_INTERFACE_INTERVAL', 15);
//api_server.php部署的服务器域名地址
define('TIME_SERVER_HOST', '');

//PHP结束标记
    </code></pre>
</details>

#### 配置文件 crontab
  * 配置文件描述 ：配置文件
  * 配置文件路径：/etc/crontab

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看crontab</font>
        </mark>
    </summary>
<pre><code>  
    
    SHELL=/bin/bash
    PATH=/sbin:/bin:/usr/sbin:/usr/bin
    MAILTO=root
    HOME=/usr/local/nginx/html
    # For details see man 4 crontabs
    # Example of job definition:
    # .---------------- minute (0 - 59)
    # |  .------------- hour (0 - 23)
    # |  |  .---------- day of month (1 - 31)
    # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
    # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
    # |  |  |  |  |
    # *  *  *  *  * user-name  command to be executed
    #事件处理定时任务
    
    * * * * * root  /usr/bin/php /usr/local/nginx/html/cli.php  Smart/EventCron/eventHandle >> /data/nginxlogs/event_handle.log &
    #redis数据passive更新定时任务
    */10 * * * *  root /usr/bin/php     /usr/local/nginx/html/heart/cron.php >> /data/nginxlogs/passive_cron.log &

</code></pre>
</details>

#### 配置文件 db.php-smart
  * 配置文件描述 ：配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Smart/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-smart</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
// /usr/local/nginx/html/Application/Smart/Conf/db.php 
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');


define('ORDER_SYNC_RETURN', 'http://112.35.86.168:8090/onemallExchange/OpenService/acceptOrderResult');  //程序访问
define('ORDER_SYNC_LOG', '/data/onemall/log/orderSync.log');
define('ARCHIVE_SYNC_LOG', '/data/onemall/log/archiveSync.log');
define('ORDER_SYNC_RETURN_LOG', '/data/onemall/log/orderSyncReturn.log');
define('MEMBER_FTP_SERVER', '192.168.10.5');
define('MEMBER_FTP_USERNAME', 'hetv_online');
define('MEMBER_FTP_PASSWORD', 'Ftp@Online_456');
define('MEMBER_FTP_PORT', '50021');
define('MEMBER_FTP_PASV', true);
define('MEMBER_FTP_SSL', false);
define('MEMBER_FTP_TIMEOUT', 60);
define('MEMBER_FTP_IN', '/in');
define('MEMBER_FTP_OUT', '/out');
define('MEMBER_FTP_FILE_IN', '/data/onemall/in');
define('MEMBER_FTP_FILE_OUT', '/data/onemall/out');
define('MEMBER_FTP_FILE_LOCAL', '/callback');//反馈报文本地地址（目前只有咪咕使用）

define('CMS_LOGIN_URL','http://cms-web/Qwadmin/CommonLogin/login?token=');    //程序访问

// 主域名
define('URL_HOST', '');   //浏览器后台管理员访问
// 媒资管理系统地址，用于影音服务调取媒资系统接口
define('MEIZIOTT_URL', 'http://cms-web/');     //程序访问
// 敏感词域名
define('SENSITIVE_WORDS_HOST', 'http://abtvsp-api/');   //程序访问
/*对账域名*/
define('CASH_HOSTS', 'http://acs-web/');   //程序访问

//平台标识
define('PLATFORM_IDENTIFICATION','center');
//onemall存量项目绑定默认版面处理接口地址
define('ONEMALL_DEFAULT_LAYOUT_SET_URL', 'http://onemall-api/Interfaces/StockDeal/addDefaultLayout');  //程序访问



define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');

define('APP_ID', '');
define('SECRET', '');
define('KEYS', '');
define('SMS_KEYS', '');
define('APP_ID', 'wx306ec33baa8025e7');
define('SECRET', '00fe04addd7eddf0048d4e532351de8d');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');
define('APP_ID', 'wxaddbbb291b9539d7');
define('SECRET', '76f16722dc57d0c9ff39a6026a9a36c4');
define('KEYS', '#$D2de53$2fxz');
define('SMS_KEYS', '8PU^j;&3#sb');

//网关启动图
define('GATEWEY_URL','http://abtvsp-api/');   //程序访问
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
define('GATEWAY_AUDIT_IN_PROGRESS',3);//审核中*/



//数据统计相关配置-----------start--------------
//DATA_ANALYSIS_PROV配置
define('BeiJing_ANALYST_API', 'http://analyst-api');
define('ShanDong_ANALYST_API', 'http://analyst-api');
define('FuJian_ANALYST_API', 'http://analyst-api');
define('ShanXi_ANALYST_API', 'http://analyst-api');
define('JiangXi_ANALYST_API', 'http://analyst-api');
define('HeBei_ANALYST_API', 'http://analyst-api');
define('GuangDong_ANALYST_API', 'http://analyst-api');
define('YunNan_ANALYST_API', 'http://analyst-api');
define('HuBei_ANALYST_API', 'http://analyst-api');
define('NeiMeng_ANALYST_API', 'http://analyst-api');
define('HaiNan_ANALYST_API', 'http://analyst-api');
define('GuangXi_ANALYST_API', 'http://analyst-api');
define('ChongQing_ANALYST_API', 'http://analyst-api');
define('LiaoNing_ANALYST_API', 'http://analyst-api');
define('AnHui_ANALYST_API', 'http://analyst-api');
define('HeNan_ANALYST_API', 'http://analyst-api');
define('HeiLongJiang_ANALYST_API', 'http://analyst-api');
define('TianJin_ANALYST_API', 'http://analyst-api');
define('GuangXiZhuangZu_ANALYST_API', 'http://analyst-api');
define('ShangHai_ANALYST_API', 'http://analyst-api');
define('QingHai_ANALYST_API', 'http://analyst-api');
define('JiLin_ANALYST_API', 'http://analyst-api');
define('JiangSu_ANALYST_API', 'http://analyst-api');
define('ZheJiang_ANALYST_API', 'http://analyst-api');
define('ShanXi2_ANALYST_API', 'http://analyst-api');
define('HuNan_ANALYST_API', 'http://analyst-api');
define('SiChuan_ANALYST_API', 'http://analyst-api');
define('GuiZhou_ANALYST_API', 'http://analyst-api');
define('XiZang_ANALYST_API', 'http://analyst-api');
define('GanSu_ANALYST_API', 'http://analyst-api');
define('NingXia_ANALYST_API', 'http://analyst-api');
define('XinJiang_ANALYST_API', 'http://analyst-api');

//DATA_ANALYSIS_PROV_DEVICE配置
define('Beijing_DEVICE_API', 'http://dsmart-api');
define('ShanDong_DEVICE_API', 'http://dsmart-api');
define('FuJian_DEVICE_API', 'http://dsmart-api');
define('ShanXi_DEVICE_API', 'http://dsmart-api');
define('JiangXi_DEVICE_API', 'http://dsmart-api');
define('HeBei_DEVICE_API', 'http://dsmart-api');
define('GuangDong_DEVICE_API', 'http://dsmart-api');
define('YunNan_DEVICE_API', 'http://dsmart-api');
define('HuBei_DEVICE_API', 'http://dsmart-api');
define('NeiMeng_DEVICE_API', 'http://dsmart-api');
define('HaiNan_DEVICE_API', 'http://dsmart-api');
define('GuangXi_DEVICE_API', 'http://dsmart-api');
define('ChongQing_DEVICE_API', 'http://dsmart-api');
define('LiaoNing_DEVICE_API', 'http://dsmart-api');
define('AnHui_DEVICE_API', 'http://dsmart-api');
define('HeNan_DEVICE_API', 'http://dsmart-api');
define('HeiLongJiang_DEVICE_API', 'http://dsmart-api');
define('TianJin_DEVICE_API', 'http://dsmart-api');
define('GuangXiZhuangZu_DEVICE_API', 'http://dsmart-api');
define('ShangHai_DEVICE_API', 'http://dsmart-api');
define('QingHai_DEVICE_API', 'http://dsmart-api');
define('JiLin_DEVICE_API', 'http://dsmart-api');
define('JiangSu_DEVICE_API', 'http://dsmart-api');
define('ZheJiang_DEVICE_API', 'http://dsmart-api');
define('ShanXi2_DEVICE_API', 'http://dsmart-api');
define('HuNan_DEVICE_API', 'http://dsmart-api');
define('SiChuan_DEVICE_API', 'http://dsmart-api');
define('GuiZhou_DEVICE_API', 'http://dsmart-api');
define('XiZang_DEVICE_API', 'http://dsmart-api');
define('GanSu_DEVICE_API', 'http://dsmart-api');
define('NingXia_DEVICE_API', 'http://dsmart-api');
define('XinJiang_DEVICE_API', 'http://dsmart-api');

//数据统计相关配置-----------end--------------



//PHP结束标记
    </code></pre>
</details>

#### 配置文件 db.php-api
  * 配置文件描述 ：终端接口配置文件
  * 配置文件路径：/usr/local/nginx/html/Application/Api/Conf/db.php

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-api</font>
        </mark>
    </summary>
    <pre><code>  
//PHP起始标记
//mysql配置
define('DB_TYPE', 'mysql');
define('DB_HOST', '10.10.10.122');
define('DB_NAME', 'smart');
define('DB_USER', 'root');
define('DB_PWD', '123.com');
define('DB_PORT', '3306');
define('DB_PREFIX', 'smart_');
//redis配置
define('REDIS_HOST', '10.10.10.122');
define('REDIS_PORT', '6381');
define('REDIS_AUTH', '');
define('SESSION_EXPIRE', '900');
//redis连接超时时间
define('REDIS_TIMEOUT',3);
<br/>
define('APPID', 'wx6e60f9972052c406');//小程序AppID
define('APPSERVER', '3d98750fe0fec83a015bc973b23566c9');//小程序Server
define('WXCODE', 'http://assistant-api');//H5 地址  终端访问
//PHP结束标记
    </code></pre>
</details>



### 2.24  服务模块 videopay-h5
#### 模块描述

* 模块名称：videopay-h5
* 负责人：李航飞
* 模块类型：h5
* videopay-h5模块

#### 依赖服务及模块
* 依赖模块:smart-api,acs-web

#### 配置文件 config.js
  * 配置文件描述 ：配置文件
  * 配置文件路径：/var/shulian/js/config.js

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.js</font>
        </mark>
    </summary>
    <pre><code>  
/*接口域名配置*/
//ajax接口路径
var ajaxUrl = 'http://smart-api-pre01.sllhtv.com:50080/', 
    bindRoomUrl = 'http://acs-web-pre01.sllhtv.com:50080'; //绑定房间号
    </code></pre>
</details>

### 2.25  服务模块 weather-h5
#### 模块描述

* 模块名称：weather-h5
* 负责人：李航飞
* 模块类型：h5
* weather-h5模块：天气H5前端页面

#### 依赖服务及模块
* 依赖模块:smart-api

#### 配置文件 config.js
  * 配置文件描述 ：天气H5前端配置文件
  * 配置文件路径：/var/shulian/config/index.js 

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.js</font>
        </mark>
    </summary>
    <pre><code>  
var host = 'http://smart-api-pre01.sllhtv.com:50080'
    </code></pre>
</details>

### 2.26  服务模块 weather-job
#### 模块描述

* 模块名称：weather-job
* 负责人：叶剑飞
* 模块类型：job
* weather-job模块：天气计划任务

#### 依赖服务及模块
* redis
* mysql
* 依赖模块:无

#### 配置文件 config.yml
  * 配置文件描述 ：天气计划任务配置文件
  * 配置文件路径：/var/shulian/config.yml

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.yml</font>
        </mark>
    </summary>
    <pre><code>  
Redis:
  host: '10.10.10.122'
  port: 6381
  #password: '123'
  </br>
MySQL:
  host: '10.10.10.122'
  port: 3306
  username: 'root'
  password: '123.com'
  database: 'smart'
  </br>
KeyPrefix: "city_key_"
</br>
WeatherHost: "http://wthrcdn.etouch.cn/WeatherApi?citykey="
    </code></pre>
</details>

### 2.27  服务模块 weather-api
#### 模块描述

* 模块名称：weather-api
* 负责人：叶剑飞
* 模块类型：api
* weather-api模块:天气接口

#### 依赖服务及模块
* redis
* mysql
* 依赖模块:无

#### 配置文件 config.yml
  * 配置文件描述 ：天气接口配置文件
  * 配置文件路径：/var/shulian/config.yml

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看config.yml</font>
        </mark>
    </summary>
    <pre><blockcode>  
Redis:
  host: '10.10.10.122'
  port: 6381
  #password: '123'
  </br>
MySQL:
  host: '10.10.10.122'
  port: 3306
  username: 'root'
  password: '123.com'
  database: 'smart'
  </br>
KeyPrefix: "city_key_"
  </br>
WeatherHost: "http://wthrcdn.etouch.cn/WeatherApi?citykey="
    </blockcode></pre>
</details>

### 2.28  服务模块 alien-pad-api

#### 模块描述

* 模块名称：alien-pad-api
* 负责人：马冬冬
* 模块类型：微服务模块
* alien-pad-api模块：消息收集服务和心跳服务

#### 依赖服务及模块

* 依赖模块:Redis，RabbitMQ

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：/app/target/classes/application.yml

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml</font>
        </mark>
    </summary>
    <pre><code> 
</br>
## 修改active指定使用的配置：dev（开发环境） test（测试环境） prod（生产环境）
    spring:
      profiles:
        active: test
</br>  
## redis配置 （地址、端口、密码）
    spring:
      # redis配置
      redis:
        # Redis数据库索引（默认为0）
        database: 0
        # Redis服务器地址
        host: 127.0.0.1
        # Redis服务器连接端口
        port: 6379
        # Redis服务器连接密码（默认为空）
        password:
</br>
## rabbit配置（地址、端口、用户、密码、虚拟host）
	# 配置rabbitMq 服务器
    rabbitmq:
      host: 192.168.31.213
      port: 5672
      username: admin
      password: 123456
      # 虚拟host可以不设置，使用server默认host，设置时需在web中手动创建Virtual Hosts
      virtual-host: padAmHost
</br>
## appid配置（需运营向集客监控平台申请）
    jike-monitor-platform:
        appId: c4e42c00-ec2e-11ea-9cb8-adfb47203a91
    </code></pre>
</details>

### 2.29  服务模块 alien-pad-report-api

#### 模块描述

* 模块名称：alien-pad-report-api
* 负责人：杨文超
* 模块类型：微服务模块
* alien-pad-report-api模块：消息上报服务

#### 依赖服务及模块

* 依赖模块:Redis，RabbitMQ

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：/app/target/classes/application.yml

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml</font>
        </mark>
    </summary>
    <pre><code> 
</br>
## 修改active指定使用的配置：dev（开发环境） test（测试环境） prod（生产环境）
    spring:
      profiles:
        active: test
</br>  
## redis配置 （地址、端口、密码）
    spring:
      # redis配置
      redis:
        # Redis数据库索引（默认为0）
        database: 0
        # Redis服务器地址
        host: 127.0.0.1
        # Redis服务器连接端口
        port: 6379
        # Redis服务器连接密码（默认为空）
        password:
</br>
## rabbit配置（地址、端口、用户、密码、虚拟host）
	# 配置rabbitMq 服务器
    rabbitmq:
      host: 192.168.31.213
      port: 5672
      username: admin
      password: 123456
      # 虚拟host设置时需在web中手动创建对应Virtual Hosts
      virtual-host: padAmHost
</br>
## 集客监控平台接入配置（api地址、appid需运营向集客监控平台申请）
    jike-monitor-platform:
      # 业务平台 APPID
      appid: c4e42c00-ec2e-11ea-9cb8-adfb47203a91
      # 认证地址
      token_url: http://112.35.166.136:18081/g/gw/interface/addAccessToken
      # 性能消息上报地址
      performance_url: http://112.35.166.136:18081/g/gw/interface/performance/v2.0/data
      # 警告/心跳上报地址
      warn_heart_url: http://112.35.166.136:18081/g/gw/interface/message/ingest/hlt_alarm
      #消息队列上报失败，是否重试
      fail_retry_enable: false
      #消息队列上报失败,重试次数
      fail_retry_count: 5
    </code></pre>
</details>





###  服务模块 yst-video-sync-api

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：http://gitlab.sllhtv.com/oma/config/tree/develop/dev03/SSI/yst-video-sync-api

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml(以下为新增)</font>
        </mark>
    </summary>
    <pre><code>
server:
  port: 80
  servlet:
    context-path: /sync
# 监控配置
management:
  endpoints:
    web:
      exposure:
        include: health
# 日志配置
logging:
  config: classpath:logback-spring.xml
# spring配置
spring:
  application:
    name: yst-video-sync-api
  # 运行环境 dev开发环境、test测试环境、prod生产环境
  profiles:
    active: dev
  # 编码设置
  http:
    encoding:
      force: true
      enabled: true
      charset: UTF-8
  # rabbitmq配置
  rabbitmq:
    host: 10.10.10.109
    port: 5672
    username: guest
    password: guest
    virtual-host: yst-sync
    publisher-confirm-type: correlated
    publisher-returns: true
   </code></pre>
</details>



###  服务模块 yst-video-sync-job

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：http://gitlab.sllhtv.com/oma/config/tree/develop/dev03/SSI/yst-video-sync-job

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml(以下为新增)</font>
        </mark>
    </summary>
    <pre><code>
server:
  port: 80
  servlet:
    context-path: /sync-job
# 监控配置
management:
  endpoints:
    web:
      exposure:
        include: health
# 日志配置
logging:
  config: classpath:logback-spring.xml
# spring配置
spring:
  application:
    name: yst-video-sync-job
  # 运行环境 dev开发环境、test测试环境、prod生产环境
  profiles:
    active: dev
  # 编码设置
  http:
    encoding:
      force: true
      enabled: true
      charset: UTF-8
  # mongodb配置
  data:
    mongodb:
      host: 10.10.10.109
      port: 27017
      database: yst-sync
      auto-index-creation: false
      option:
        min-connection-per-host: 5  #最小连接数
        max-connection-per-host: 10 #最大连接数
        threads-allowed-to-block-for-connection-multiplier: 5
  # rabbitmq配置
  rabbitmq:
    host: 10.10.10.109
    port: 5672
    username: guest
    password: guest
    virtual-host: yst-sync
    listener:
      simple:
        acknowledge-mode: auto
        concurrency: 5
        max-concurrency: 10
        prefetch: 1
  # 易视腾开销户PAI地址
  yst-video-sync-api: http://ucs-yst01.sllhtv.com:8092/adapter-api/syncUser
   </code></pre>
</details>



###  服务模块 yst-video-resync-api

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：http://gitlab.sllhtv.com/oma/config/tree/develop/dev03/SSI/yst-video-resync-api

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml(以下为新增)</font>
        </mark>
    </summary>
    <pre><code>
server:
  port: 80
  servlet:
    context-path: /resync
# 监控配置
management:
  endpoints:
    web:
      exposure:
        include: health
# 日志配置
logging:
  config: classpath:logback-spring.xml
# spring配置
spring:
  application:
    name: yst-video-resync-api
  # 运行环境 dev开发环境、test测试环境、prod生产环境
  profiles:
    active: dev
  # 编码设置
  http:
    encoding:
      force: true
      enabled: true
      charset: UTF-8
  # mongodb配置
  data:
    mongodb:
      host: 10.10.10.109
      port: 27017
      database: yst-sync
      auto-index-creation: false
      option:
        min-connection-per-host: 5  #最小连接数
        max-connection-per-host: 10 #最大连接数
        threads-allowed-to-block-for-connection-multiplier: 5
  # rabbitmq配置
  rabbitmq:
    host: 10.10.10.109
    port: 5672
    username: guest
    password: guest
    virtual-host: yst-sync
    publisher-confirm-type: correlated
    publisher-returns: true
   </code></pre>
</details>



###  服务模块 yst-order-sync-api

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：http://gitlab.sllhtv.com/oma/config/tree/develop/dev03/SSI/yst-order-sync-api

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml(以下为新增)</font>
        </mark>
    </summary>
    <pre><code>
server:
  port: 80
  servlet:
    context-path: /order
# 监控配置
management:
  endpoints:
    web:
      exposure:
        include: health
# 日志配置
logging:
  config: classpath:logback-spring.xml
# spring配置
spring:
  application:
    name: yst-order-sync-api
  # 运行环境 dev开发环境、test测试环境、prod生产环境
  profiles:
    active: dev
  # 编码设置
  http:
    encoding:
      force: true
      enabled: true
      charset: UTF-8
  # mysql配置
  datasource:
    url: jdbc:mysql://10.10.10.120:3306/smart?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai&autoReconnect=true&failOverReadOnly=false&zeroDateTimeBehavior=convertToNull
    username: root
    password: 123.com
    driver-class-name: com.mysql.cj.jdbc.Driver
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      initialSize: 5
      minIdle: 5
      maxActive: 10
      maxWait: 10000
      timeBetweenEvictionRunsMillis: 30000
      minEvictableIdleTimeMillis: 300000
      validationQuery: SELECT 1 FROM DUAL
      testWhileIdle: true
# mybatis配置
mybatis:
  mapper-locations: classpath:/mappings/*.xml
  type-aliases-package: cn.digitlink.ordersync.entity
# 易视腾增值业务接口
yst-order-sync-api:
  private-key: 12345678
  url: http://ucs-yst01.sllhtv.com:8092/adapter-api/v3/order/sync
   </code></pre>
</details>




###  服务模块 data-computing-job

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：http://gitlab.sllhtv.com/oma/config/tree/develop/dev03/SSI/data-computing-job

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml(以下为新增)</font>
        </mark>
    </summary>
    <pre><code>
server:
  port: 80
  servlet:
    context-path: /
<br>
# 监控配置
management:
  endpoints:
    web:
      exposure:
        include: health
<br>
# 日志配置
logging:
  config: classpath:logback-spring.xml
<br>
# spring配置
spring:
  application:
    name: data-computing-job
<br>
  # 运行环境 dev开发环境、test测试环境、prod生产环境
  profiles:
    active: dev
<br>
  # 编码设置
  http:
    encoding:
      force: true
      enabled: true
      charset: UTF-8
<br>
  # mysql配置
  datasource:
    url: jdbc:mysql://10.10.10.120:3306/smart?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai&autoReconnect=true&failOverReadOnly=false
    username: root
    password: 123.com
    driver-class-name: com.mysql.cj.jdbc.Driver
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      initialSize: 5
      minIdle: 5
      maxActive: 10
      maxWait: 10000
      timeBetweenEvictionRunsMillis: 30000
      minEvictableIdleTimeMillis: 300000
      validationQuery: SELECT 1 FROM DUAL
      testWhileIdle: true
<br>
  # mongodb配置（易视腾数据同步）
  data:
    mongodb:
      host: 10.10.10.109
      port: 17017
      database: test
      username: root
      password: SU9A4NRD
      authentication-database: admin
      option:
        min-connection-per-host: 5  #最小连接数
        max-connection-per-host: 10 #最大连接数
        threads-allowed-to-block-for-connection-multiplier: 5
<br>
# mybatis配置
mybatis:
  mapper-locations: classpath:/mappings/*.xml
  type-aliases-package: cn.digitlink.stats.entity.mysql
<br>
# ftp服务配置
ftp:
  host: 114.251.62.161
  port: 50021
  username: yst
  password: yst123456
  base-path: /
  base-url-prefix: ftp://114.251.62.161:50021/
<br>
# 统计相关配置
stats:
  # 产品包
  prod-packages: {-1: 其他, 1: 通用免费包, 2: 豪华定制包, 3: 酒店定制包}
  # 资费包
  tariff-packages: {-1: 未开通任何服务, 4: 酒店对接入住欢迎服务, 5: 酒店对接标准服务, 6: 高端定制开发服务}
  # 牌照方
  licenses: {1: 未来电视, 2: 百事通, 3: 央广银河, 4: 芒果TV, 5: 华数TV, 6: 国广, 7: 南传, 99: 其他}
  # 易视腾（name）与数联（id）省份对应关系
  yst_provinces: {0: 未知, 1: 全国, 2: 上海, 3: 天津, 4: 重庆, 5: 河北, 6: 陕西, 7: 山西, 8: 北京, 9: 辽宁, 10: 吉林, 11: 黑龙江, 12: 江苏, 13: 浙江, 14: 江西, 15: 山东, 16: 河南, 17: 湖南, 18: 湖北, 19: 广东, 20: 广西, 21: 海南, 22: 四川, 23: 贵州, 24: 云南, 25: 西藏, 26: 甘肃, 27: 青海, 28: 宁夏, 29: 新疆, 30: 安徽, 31: 内蒙古, 32: 福建, 40: 台湾, 41: 香港, 42: 澳门 }
<br>
# 统计任务周期配置
cron:
  #------------------------实时数据-----------------------------------
  # 在线终端
  device-online-task: 0 0/5 * * * ?
  #------------------------终端趋势-----------------------------------
  # 发展趋势
  device-develop-task: 5 0 0 * * ?
  # 活跃数量
  device-activation-task: 15 0 0 * * ?
  # 增长指数
  device-growth-index-task: 0 5 0 1 * ?
  #------------------------终端属性-----------------------------------
  # 全国终端分布
  device-distribution-task: 30 0 0 * * ?
  # 产品包
  device-package-task: 35 0 0 * * ?
  # 牌照方
  device-license-task: 40 0 0 * * ?
  # 订购来源
  device-order-source-task: 45 0 0 * * ?
  # Launcher
  device-launcher-task: 50 0 0 * * ?
  #------------------------自服务------------------------------------
  # 省模板数量
  layout-count-task: 55 0 0 * * ?
  # 终端模板类型分布
  layout-distribution-task: 0 1 0 * * ?
  # 系统版面应用
  layout-use-task: 5 1 0 * * ?
  # 客房服务
  room-service-task: 10 1 0 * * ?
  # 企业消息发送
  msg-send-task: 15 1 0 * * ?
   </code></pre>
</details>




###  服务模块 live-data-api

#### 配置文件 application.yml

  * 配置文件描述 ：配置文件
  * 配置文件路径：http://gitlab.sllhtv.com/oma/config/tree/develop/dev03/SSI/live-data-api

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看application.yml(以下为新增)</font>
        </mark>
    </summary>
    <pre><code>
server:
  port: 80
  servlet:
    context-path: /
<br>
# 监控配置
management:
  endpoints:
    web:
      exposure:
        include: health
<br>
# 日志配置
logging:
  config: classpath:logback-spring.xml
<br>
# spring配置
spring:
  application:
    name: live-data-api
<br>
  # 运行环境 dev开发环境、test测试环境、prod生产环境
  profiles:
    active: dev
<br>
  # 编码设置
  http:
    encoding:
      force: true
      enabled: true
      charset: UTF-8
<br>
  # mysql配置
  datasource:
    url: jdbc:mysql://10.10.10.120:3306/smart?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai&autoReconnect=true&failOverReadOnly=false
    username: root
    password: 123.com
    driver-class-name: com.mysql.cj.jdbc.Driver
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      initialSize: 5
      minIdle: 5
      maxActive: 10
      maxWait: 10000
      timeBetweenEvictionRunsMillis: 30000
      minEvictableIdleTimeMillis: 300000
      validationQuery: SELECT 1 FROM DUAL
      testWhileIdle: true
<br>
  # mongodb配置（易视腾数据同步）
  data:
    mongodb:
      host: 10.10.10.109
      port: 17017
      database: test
      username: root
      password: SU9A4NRD
      authentication-database: admin
      auto-index-creation: false
      option:
        min-connection-per-host: 5  #最小连接数
        max-connection-per-host: 10 #最大连接数
        threads-allowed-to-block-for-connection-multiplier: 5
<br>
# mybatis配置
mybatis:
  mapper-locations: classpath:/mappings/*.xml
  type-aliases-package: cn.digitlink.stats.entity.mysql
<br>
# 前端省份名称配置
web:
  tv_provinces: {2: 上海市, 3: 天津市, 4: 重庆市, 5: 河北省, 6: 陕西省, 7: 山西省, 8: 北京市, 9: 辽宁省, 10: 吉林省, 11: 黑龙江省, 12: 江苏省, 13: 浙江省, 14: 江西省, 15: 山东省, 16: 河南省, 17: 湖南省, 18: 湖北省, 19: 广东省, 20: 广西壮族自治区, 21: 海南省, 22: 四川省, 23: 贵州省, 24: 云南省, 25: 西藏自治区, 26: 甘肃省, 27: 青海省, 28: 宁夏回族自治区, 29: 新疆维吾尔自治区, 30: 安徽省, 31: 内蒙古自治区, 32: 福建省, 40: 台湾省, 41: 香港特别行政区, 42: 澳门特别行政区}
  pc_provinces: {2: 上海, 3: 天津, 4: 重庆, 5: 河北省, 6: 陕西省, 7: 山西省, 8: 北京, 9: 辽宁省, 10: 吉林省, 11: 黑龙江省, 12: 江苏省, 13: 浙江省, 14: 江西省, 15: 山东省, 16: 河南省, 17: 湖南省, 18: 湖北省, 19: 广东省, 20: 广西壮族自治区, 21: 海南省, 22: 四川省, 23: 贵州省, 24: 云南省, 25: 西藏自治区, 26: 甘肃省, 27: 青海省, 28: 宁夏回族自治区, 29: 新疆维吾尔自治区, 30: 安徽省, 31: 内蒙古自治区, 32: 福建省, 40: 台湾省, 41: 香港特别行政区, 42: 澳门特别行政区}
  yst_provinces: {2: 上海, 3: 天津, 4: 重庆, 5: 河北, 6: 陕西, 7: 山西, 8: 北京, 9: 辽宁, 10: 吉林, 11: 黑龙江, 12: 江苏, 13: 浙江, 14: 江西, 15: 山东, 16: 河南, 17: 湖南, 18: 湖北, 19: 广东, 20: 广西, 21: 海南, 22: 四川, 23: 贵州, 24: 云南, 25: 西藏, 26: 甘肃, 27: 青海, 28: 宁夏, 29: 新疆, 30: 安徽, 31: 内蒙古, 32: 福建, 40: 台湾, 41: 香港, 42: 澳门}
   </code></pre>
</details>

### 服务模块 province-online-api
#### 模块描述

* 模块名称：province-online-api
* 模块类型：api 
* 提供公网接口服务

#### 依赖服务及模块
* mysql 5.x

#### 配置文件 db.php-api
* 配置文件描述 ：省业务boss接口配置文件
* 配置文件路径：/usr/local/nginx/html/db.php-api

<details>
    <summary>
        <mark>
            <font color=darkred>点击查看db.php-api</font>
        </mark>
    </summary>
<pre><code> 
     
    //PHP起始标记
    define('DB_TYPE', 'mysql');
    define('DB_HOST', '192.168.10.117');
    define('DB_NAME', 'province_data');
    define('DB_USER', 'province_data');
    define('DB_PWD', 'province@data');
    define('DB_PORT', '3306');
    define('DB_PREFIX', 'prov_');
    
    define('ARCHIVE_SYNC_LOG', '/data/nginxlog/archiveSync.log');
    define('ORDER_SYNC_RETURN_PROVINCE_LOG', '/data/nginxlog/orderSyncProvinceReturn.log');
    define('ORDER_SYNC_PROVINCE_LOG', '/data/nginxlog/orderProvinceSync.log');
    
    //是否开启和商务业务
    define('IF_OPEN_ANDTVSP',false);
    
    //TOKEN有效时间
    define('TOKEN_FAILURE_TIME',2*60);
    
    //和商务业务数据库
    define('SMART_DB_TYPE', 'mysql');
    define('SMART_DB_HOST', '192.168.10.64');
    define('SMART_DB_NAME', 'smart');
    define('SMART_DB_USER', 'smart');
    define('SMART_DB_PWD', '123abcABC!');
    define('SMART_DB_PORT', '3307');
    define('SMART_DB_PREFIX', 'smart_');
    //PHP结束标记

</code></pre>

</details>

## 3. 数据库配置

#### 配置项
* 配置表xxxx

### 其它


