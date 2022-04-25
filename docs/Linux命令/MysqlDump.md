# MysqlDump

## 备份数据库
### 安装mysql mysqldump 命令
    yum install mysql 
    which mysqldump
### 新建数据库配置文件
    mkdir /root/mysql -p
    sudo tee /root/mysql/my.cnf <<EOF
    [client]
    port = 3306
    default-character-set = utf8mb4
    host = 192.168.17.82
    user = 'root'
    password = 'password'
    EOF
> 普通用户可以追加日志
### 查询数据库
    mysql --defaults-file=my.cnf -e 'show databases;'
### 新建数据库
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_contract DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_contract_v3 DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_ops DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_p2p DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_project DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_rfp DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_tenant DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
    mysql --defaults-file=my.cnf -e "CREATE DATABASE IF NOT EXISTS pre01_wms DEFAULT CHARSET utf8 COLLATE utf8_general_ci;";
### 导出数据库
    mysqldump --defaults-extra-file=my.cnf demo_contract |gzip >demo_contract.gz
    mysqldump --defaults-extra-file=my.cnf demo_contract_3.0 |gzip >demo_contract_3.0.gz
    mysqldump --defaults-extra-file=my.cnf demo_ops |gzip > demo_ops.gz
    mysqldump --defaults-extra-file=my.cnf demo_p2p |gzip >demo_p2p.gz
    mysqldump --defaults-extra-file=my.cnf demo_project |gzip >demo_project.gz
    mysqldump --defaults-extra-file=my.cnf demo_rfp |gzip >demo_rfp.gz
    mysqldump --defaults-extra-file=my.cnf demo_tenant |gzip >demo_tenant.gz
    mysqldump --defaults-extra-file=my.cnf demo_wms |gzip >demo_wms.gz
### 恢复数据库
    mysql --defaults-file=my.cnf pre01_contract    < contract
    mysql --defaults-file=my.cnf pre01_contract_v3 < contract_v3
    mysql --defaults-file=my.cnf pre01_ops         < ops 
    mysql --defaults-file=my.cnf pre01_p2p         < p2p
    mysql --defaults-file=my.cnf pre01_project     < project
    mysql --defaults-file=my.cnf pre01_rfp         < rfp
    mysql --defaults-file=my.cnf pre01_tenant      < tenant
    mysql --defaults-file=my.cnf pre01_wms         < wms
