#!/bin/bash
# k8s 更换
##https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/migrating-from-dockershim/change-runtime-containerd/

# 需要添加dns
tee -a /etc/resolv.conf <<-'EOF'
    nameserver 223.5.5.5
EOF
# master
sudo tee -a /etc/hosts <<-'EOF'
172.16.2.180   apiserver.qinghua-uat.com
172.16.2.180   qinghua-uat-node180
EOF
### 系统初始化
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
swapoff -a
sed -i 's#SELINUX=enforcing#SELINUX=disabled#g'  /etc/selinux/config
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab



sudo tee /etc/sysconfig/modules/br_netfilter.modules<<-'EOF'
#!/bin/bash
modprobe br_netfilter
EOF
sudo chmod 755 /etc/sysconfig/modules/br_netfilter.modules
sudo bash /etc/sysconfig/modules/br_netfilter.modules
sudo lsmod |grep br_netfilter

sudo lsmod | grep -e ip_vs -e nf_conntrack_ipv4
sudo yum install ipset  ipvsadm -y

sudo tee -a /etc/sysctl.conf <<-'EOF'
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward=1
vm.swappiness = 0
EOF
sysctl -p

# 安装 docker 包含在container
yum install -y yum-utils device-mapper-persistent-data
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{ "registry-mirrors": ["https://i3khnsz8.mirror.aliyuncs.com"],
"log-driver":"json-file",
"log-opts": {"max-size":"100m", "max-file":"3"},
"data-root": "/data/docker-root" }
EOF

#sudo systemctl daemon-reload
#sudo systemctl restart docker

# 配置container
mkdir /data/podslog/pods -p
ln -s /data/podslog/pods /var/log/
cd /var/log/pods/ || exit


sudo containerd --version
sudo mkdir /data/containerd -p
sudo containerd config default > /etc/containerd/config.toml

sudo sed -i 's#/var/lib/containerd#/data/containerd/var/lib/containerd#g' /etc/containerd/config.toml
sudo sed -i 's#/run/containerd\"#/data/containerd/run/containerd\"#g' /etc/containerd/config.toml
sudo sed -i 's#SystemdCgroup = false#SystemdCgroup = true#g' /etc/containerd/config.toml
sudo sed -i 's#/run/containerd/containerd.sock#/var/run/containerd/containerd.sock#g' /etc/containerd/config.toml
sudo sed -i 's#k8s.gcr.io/pause:3.6#registry.aliyuncs.com/google_containers/pause:3.9#g' /etc/containerd/config.toml

sudo systemctl enable containerd --now
sudo systemctl start containerd
sudo systemctl status containerd



## kubeadmin 安装k8s
sudo tee /etc/yum.repos.d/kubernetes.repo<<-'EOF'
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubelet-1.27*  kubeadm-1.27*  kubectl-1.27*
#yum install -y kubelet  kubeadm  kubectl
#systemctl enable docker.service
systemctl enable kubelet.service


## k8s 初始化
sudo tee /etc/kubernetes/kubeadm-config.yaml <<-'EOF'
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
controlPlaneEndpoint: "apiserver.qinghua-uat.com:6443"
imageRepository: registry.aliyuncs.com/google_containers
networking:
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.64.0.0/12"
certificatesDir: /etc/kubernetes/pki
clusterName: kubernetes
---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: ipvs
EOF

#配置containerd
#https://blog.frognew.com/2023/01/kubeadm-install-kubernetes-1.26.html

## 使用破解 100 年的 kubeadm 初始化
kubeadm init --config /etc/kubernetes/kubeadm-config.yaml --upload-certs

## 配置 运行时管理命令crictl
crictl --version
crictl config runtime-endpoint unix:///var/run/containerd/containerd.sock
cat /etc/crictl.yaml
ll /var/run/containerd/containerd.sock
systemctl restart containerd
crictl version
