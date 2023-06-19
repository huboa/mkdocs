# 更新证书
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