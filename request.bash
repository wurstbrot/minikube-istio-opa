#!/bin/bash

export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export INGRESS_HOST=$(minikube ip)
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT


curl -H "X-Envoy-Expected-Rq-Timeout-Ms: 75000" -H "Content-Type: application/json" -T data.json -X POST  http://$GATEWAY_URL/post
#curl -F filedata=@small.json http://$GATEWAY_URL/post # geht nicht bei größeren Dateien
#curl -F filedata=@large-file  http://$GATEWAY_URL/post
