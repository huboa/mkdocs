ETCDCTL_API=3 
etcdctl --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert="/etc/kubernetes/pki/etcd/server.crt" --key="/etc/kubernetes/pki/etcd/server.key" member list


#docker exec -it   $(docker ps |grep etcd|grep -Ev /pause|awk '{print$1}') sh -c 'ETCDCTL_API=3 ;etcdctl --endpoints=https://172.17.15.173:2379,https://172.17.15.175:2379,https://172.17.15.176:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key endpoint status --write-out=table'
docker exec -it   $(docker ps |grep etcd|grep -Ev /pause|awk '{print$1}') sh -c 'ETCDCTL_API=3 ;etcdctl --endpoints=https://172.17.15.173:2379,https://172.17.15.175:2379,https://172.17.15.176:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key member list'
#docker exec -it   $(docker ps |grep etcd|grep -Ev /pause|awk '{print$1}') sh -c 'ETCDCTL_API=3 ;etcdctl --endpoints=https://172.17.15.173:2379,https://172.17.15.175:2379,https://172.17.15.176:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key member remove 7ccfe6a8147d85cb'