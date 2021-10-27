# Istio OPA Demo
Demonstration of istio with OPA.

## Requirements
minikube

## Hints
Kubernetes smaller 1.19 required (see [github issue](https://github.com/open-policy-agent/opa/pull/3906)).

## Setup
Run `./setup.bash` and afterwards `./request.bash` to simulate requests going through OPA to the application (httpbin).
