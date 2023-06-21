# 更新证书服务端
## 查看
    kubeadm certs check-expiration
## 更新证书
    kubeadm certs renew all

## 重启服务
### 在master 上面执行
    kubectl delete pod  $(kubectl get pod -n kube-system  |grep -E  'kube-|etcd-'|cut -d ' ' -f 1|grep NODENAME) -n kube-system

## 修改config文件
    \cp  /etc/kubernetes/admin.conf $HOME/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config

# 客户端
## 查看
    openssl x509 -in /var/lib/kubelet/pki/kubelet.crt -text -noout | grep -A 2 Validity
## 手动更新
    目前下面还没有成功，可以快速删除安装
    步骤：
    备份和删除 
    cp /etc/kubernetes/kubelet.conf /etc/kubernetes/kubelet.conf_$(date +%F) 
    rm /etc/kubernetes/kubelet.conf
    在集群中具有 /etc/kubernetes/pki/ca.key 执行
    kubeadm kubeconfig user --org system:nodes --client-name system:node:zcb-qas-k8s-master176 > kubelet.conf。 $NODE 必须设置为集群中现有故障节点的名称。 手动修改生成的 kubelet.conf 以调整集群名称和服务器端点， 或传递 kubeconfig user --config（此命令接受 InitConfiguration）。 如果你的集群没有 ca.key，你必须在外部对 kubelet.conf 中的嵌入式证书进行签名。
    将得到的 kubelet.conf 文件复制到故障节点上，作为 /etc/kubernetes/kubelet.conf。
    在故障节点上重启 kubelet（systemctl restart kubelet），等待 /var/lib/kubelet/pki/kubelet-client-current.pem 重新创建。
    手动编辑 kubelet.conf 指向轮换的 kubelet 客户端证书，方法是将 client-certificate-data 和 client-key-data 替换为：
    
    client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
    client-key: /var/lib/kubelet/pki/kubelet-client-current.pem
    重新启动 kubelet。
    确保节点状况变为 Ready。
