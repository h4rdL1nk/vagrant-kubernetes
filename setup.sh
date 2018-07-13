#!/bin/bash

sudo curl -L https://github.com/kubernetes/minikube/releases/download/v0.25.2/minikube-linux-amd64 -o /usr/bin/minikube \
  && sudo chmod +x /usr/bin/minikube

sudo curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -L -o /usr/bin/kubectl \
  && sudo chmod +x /usr/bin/kubectl \
  && echo "source <(kubectl completion bash)" >> ~/.bashrc 

curl -sL https://github.com/minishift/minishift/releases/download/v1.16.1/minishift-1.16.1-linux-amd64.tgz | gunzip | tar -x minishift-1.16.1-linux-amd64/minishift \
  && sudo cp ./minishift-1.16.1-linux-amd64/minishift /usr/bin/minishift \
  && sudo chmod +x /usr/bin/minishift

minikube start --vm-driver virtualbox

kubectl run apache --replicas=2 --labels="run=load-balancer-example" --image=httpd:alpine  --port=8080
