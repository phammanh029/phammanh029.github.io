# Use traefik gateway for AKS

## Install locally using Helm
```
helm install traefik traefik/traefik -n traefik --create-namespace -f values.yaml
k apply -f test-nginx.yaml
k apply -f routes.yaml
```

