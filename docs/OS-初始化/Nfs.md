# CentOS

### 安装命令
    yum nfs-utils -y
###时间同步
    sudo tee -a /etc/fstab <<EOF
    */10 * * * * root /usr/sbin/ntpdate ntp1.aliyun.com >/dev/null  2>&1
    EOF



