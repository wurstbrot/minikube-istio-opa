#!/bin/bash
set -e

curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.11.4 sh -

minikube start --driver=kvm2 --addons=metrics-server --extra-config=apiserver.enable-admission-plugins=MutatingAdmissionWebhook --kubernetes-version='v1.18.0'

#minikube addons enable istio
#minikube addons enable ingress

export PATH=$PWD/istio-1.11.4/bin:$PATH
istioctl install --set profile=demo -y
echo "setting namespace label"
kubectl apply -f deployment/custom.yaml
kubectl label namespace default opa-istio-injection="enabled" --overwrite
sleep 2
kubectl label namespace default istio-injection="enabled" --overwrite
kubectl apply -k ./deployment

./generateData.bash

export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export INGRESS_HOST=$(minikube ip)
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo $GATEWAY_URL

curl -i http://$GATEWAY_URL/
