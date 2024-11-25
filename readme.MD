# Expense DEV Infrastructure

![alt text](expense-infra.svg)

* Make sure infra is created. 
* Every resource should have dev in its name, so that it will not overlap with prod resources.

Once infra is setup. We need to configure ingress controller to provide internet access to our expense application.

We are using bastion as our EKS client, so it will have
* K9S
* kubectl
* helm
* aws configure

* Login to bastion host and get the kubeconfig of EKS cluster
```
aws eks update-kubeconfig --region us-east-1 --name expense-dev
```

```
kubectl get nodes
```

* Create namespace expense
```
kubectl create namespace expense
```

* IAM policy

```
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.10.0/docs/install/iam_policy.json
```

* IAM Role created
```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam-policy.json
```
* Create Service account. Replace your account ID.
```
eksctl create iamserviceaccount \
--cluster=expense-dev \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::315069654700:policy/AWSLoadBalancerControllerIAMPolicy \
--override-existing-serviceaccounts \
--region us-east-1 \
--approve
```

* Install aws load balancer controller drivers through helm.

```
helm repo add eks https://aws.github.io/eks-charts
```

```
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=expense-dev --set serviceAccount.create=true --set serviceAccount.name=aws-load-balancer-controller
```

