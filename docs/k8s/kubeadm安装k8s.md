# kubelet
## node 安装
### 有旧服务需重置
    kubeadm reset
    systemctl stop kubelet
    systemctl stop docker
    rm -rf /var/lib/cni/
    rm -rf /var/lib/kubelet/*
    rm -rf /etc/cni/
    ifconfig cni0 down
    ifconfig flannel.1 down
    ifconfig docker0 down
    ip link delete cni0
    ip link delete flannel.1
    systemctl start docker
    systemctl start kubelet

### OS 优化
    modprobe br_netfilter
    sysctl -p

    sudo tee /etc/sysconfig/modules/ipvs.modules<<-'EOF'
    #!/bin/bash
    modprobe -- ip_vs
    modprobe -- ip_vs_rr
    modprobe -- ip_vs_wrr
    modprobe -- ip_vs_sh
    modprobe -- nf_conntrack_ipv4
    EOF

    sudo chmod 755 /etc/sysconfig/modules/ipvs.modules
    sudo bash /etc/sysconfig/modules/ipvs.modules 
    sudo lsmod | grep -e ip_vs -e nf_conntrack_ipv4
    sudo yum install ipset  ipvsadm -y

### 安装kubelet
    sudo tee /etc/yum.repos.d/kubernetes.repo<<-'EOF'
    [kubernetes]
    name=Kubernetes
    baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
    enabled=1
    gpgcheck=0
    repo_gpgcheck=0
    gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
    http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
    EOF
    yum install kubelet kubectl kubeadm
    yum install -y kubelet-1.23* kubeadm-1.23* kubectl-1.23*
    # 开启服务
    systemctl enable docker.service 
    systemctl enable kubelet.service

### 绑定接口
    tee -a /etc/hosts<<-'EOF'
    192.168.100.101    apiserver-dev.kubelet.com
    EOF
### 获取 主节点token 
    kubeadm token create --print-join-command
    kubeadm join apiserver-dev.kubelet.com:6443 --token gogyf0.token --discovery-token-ca-cert-hash sha256:token
    
### 标签
    kubectl label nodes   k8s-node105    node-role.kubernetes.io/node=
    kubectl label node    hostname  netenv=outside
###  修改节点 pod 上限
    grep maxPods /var/lib/kubelet/config.yaml
    maxPods: 200
