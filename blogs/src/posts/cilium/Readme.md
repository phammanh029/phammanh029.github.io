# Cilium with k3d

## Start the cluster

```bash
k3d cluster create cilium-lab \
  --servers 1 --agents 2 \
  --k3s-arg "--flannel-backend=none@server:*" \
  --k3s-arg "--disable-network-policy@server:*" \
  --k3s-arg "--disable=traefik@server:*"
```

## Install Cilium with helm

```bash
helm repo add cilium https://helm.cilium.io/
helm repo update
helm install cilium cilium/cilium --namespace kube-system \
  --set kubeProxyReplacement=true \
  --set k8sServiceHost=localhost \
  --set k8sServicePort=6443
```

## Validate the installation

```bash
kubectl -n kube-system get pods -l k8s-app=cilium
```
