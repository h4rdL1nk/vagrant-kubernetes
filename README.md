
### Start nodes
 $ vagrant up

### On master node
 # kubeadm init --apiserver-advertise-address 192.168.77.10 --pod-network-cidr 192.168.100.0/16
 # kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml

### On each minion
 # kubeadm join 192.168.77.10:6443 --token 8xrb4r.g7vfbkoxn21p8kru --discovery-token-ca-cert-hash sha256:e8d1ff7735a7c8f4b25209178b653c54546c613d805db17eb7a40847db6c7a47

### Commands from master
 # kubectl get nodes
 NAME             STATUS    ROLES     AGE       VERSION
 kubecluster-01   Ready     master    2h        v1.11.0
 kubecluster-02   Ready     <none>    15m       v1.11.0
 kubecluster-03   Ready     <none>    6m        v1.11.0

 # kubectl run apache --replicas=2 --image=httpd:alpine --port=80
 # kubectl expose deployment apache --type=NodePort
 # kubectl scale deployment apache --replicas=4

 # kubectl get service apache
 NAME      TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
 apache    NodePort   10.106.149.158   <none>        80:30770/TCP   6m
