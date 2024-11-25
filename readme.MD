# Expense DEV Infrastructure

![alt text](expense-infra.svg)

* Make sure infra is created. 
* Every resource should have dev in its name, so that it will not overlap with prod resources.

Once infra is setup. We need to configure ingress controller to provide internet access to our expense application.

We are using bastion as our EKS client, so it will have
* K9S
* kubectl
* helm

Create namespace expense
```
kubectl create namespace expense
```