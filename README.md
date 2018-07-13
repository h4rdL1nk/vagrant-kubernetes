
### Start nodes
```
 $ vagrant up
```

### On master node
```
 # sudo kubeadm init --apiserver-advertise-address 192.168.77.10 --pod-network-cidr 10.12.0.0/16 --service-cidr 10.24.0.0/16 --token 8xrb4r.g7vfbkoxn21p8kru --token-ttl 0
 # mkdir ~/.kube && sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config && sudo chown $(id -u):$(id -g) ~/.kube/config
 # sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
 # kubectl get pods --all-namespaces
```

### On each minion
```
 # sudo kubeadm join 192.168.77.10:6443 --token 8xrb4r.g7vfbkoxn21p8kru --discovery-token-unsafe-skip-ca-verification
```

### Commands from master
```
 # kubectl get nodes
 NAME             STATUS    ROLES     AGE       VERSION
 kubecluster-01   Ready     master    3m        v1.11.0
 kubecluster-02   Ready     <none>    59s       v1.11.0
 kubecluster-03   Ready     <none>    47s       v1.11.0
 kubecluster-04   Ready     <none>    38s       v1.11.0

 # kubectl run apache --replicas=16 --image=httpd:alpine --port=80
 # kubectl expose deployment apache --type=NodePort
 # kubectl scale deployment apache --replicas=4

 # kubectl get service apache
 NAME      TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
 apache    NodePort   10.106.149.158   <none>        80:30770/TCP   6m
```