#!/bin/bash

# Control Variables
shopt -s expand_aliases
environment="dev"
base_path="/media/pedro/Experiments/minikube-sandbox/" 
namespace_path="${base_path}${environment}/"
export MINIKUBE_HOME=$base_path # Create cluster in the external disk

# Installation
cd $base_path
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Instantiation
cd $namespace_path
minikube start
minikube addons enable ingress
alias kubectl="minikube kubectl --"
kubectl apply -f mongo-namespace.yaml
kubectl apply -f mongo-secret.yaml 
kubectl apply -f mongo.yaml 
kubectl apply -f mongo-configmap.yaml 
kubectl apply -f mongo-express.yaml 
kubectl apply -f mongo-express-ingress.yaml
kubens dev # Can be installed by 'snap install kubectx'
echo "Please wait..."
sleep 60 # It takes some time for the cluster to go online
xdg-open http://mymongoexpress.com/ # (need to map in /etc/hosts file)

# Run as . build.sh
