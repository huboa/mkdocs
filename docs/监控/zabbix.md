
## zabbix-agent 
### zabbix-agent install 6.0 服务器主动模式
    yum install  http://repo.zabbix.com/zabbix/6.0/rhel/7/x86_64/zabbix-agent-6.0.3-1.el7.x86_64.rpm -y
    ##配置文件
    sudo tee /etc/zabbix/zabbix_agentd.conf <<-'EOF'
    PidFile=/var/run/zabbix/zabbix_agentd.pid
    LogFile=/var/log/zabbix/zabbix_agentd.log
    LogFileSize=0
    ## 客户端被动模式，服务器发起访问
    Server=192.168.100.221
    ##ServerActive 主动模式，agent 主动注册
    #ServerActive=192.168.100.221
    Hostname=zcb-dev-k8s-node105
    Include=/etc/zabbix/zabbix_agentd.d/*.conf
    EOF
    # 网络连接配置
    sudo tee /etc/zabbix/zabbix_agentd.d/tcp-status.conf <<-'EOF'
    UserParameter=linux_status[*],/etc/zabbix/tcp-status.sh "$1" "$2" "$3"
    EOF
    
    ## 网络连接脚本
    sudo tee /etc/zabbix/tcp-status.sh<<-'EOF'
    #!/bin/bash
    TCP_STAT=$2
    TCP_STAT_VALUE=$(ss -ant | awk 'NR>1 {++s[$1]} END {for(k in s) print k,s[k]}'|grep "$TCP_STAT" | cut -d ' ' -f2)
    if [ -z $TCP_STAT_VALUE ];then
        TCP_STAT_VALUE=0
    fi
    echo $TCP_STAT_VALUE
    EOF
    sudo chmod +x /etc/zabbix/tcp-status.sh
    systemctl start zabbix-agent
    systemctl enable zabbix-agent