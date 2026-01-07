helm repo add traefik https://traefik.github.io/charts
helm repo update
kubectl create namespace traefik

1. Install CRDs
`kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml`
2. Install RBAC:
`kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.6/docs/content/reference/dynamic-configuration/kubernetes-gateway-rbac.yml`


3. Install traefik
```
helm install traefik traefik/traefik \
  --namespace traefik --set gateway.listeners.web.namespacePolicy.from=All --set providers.kubernetesGateway.enabled=true --set service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"="true"
```
If for upgrade:
```
helm upgrade -i traefik traefik/traefik \
  --namespace traefik --set gateway.listeners.web.namespacePolicy.from=All --set providers.kubernetesGateway.enabled=true --set service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal=true"
```

helm upgrade -i traefik traefik/traefik \
  --namespace traefik --values ./values.yaml