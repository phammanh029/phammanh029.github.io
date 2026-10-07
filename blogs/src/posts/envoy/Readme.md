1. Apply the CRDs and Envoy Gateway components using Helm:
```
helm template eg oci://docker.io/envoyproxy/gateway-crds-helm \
  --version v1.6.1 \
  --set crds.gatewayAPI.enabled=true \
  --set crds.gatewayAPI.channel=standard \
  --set crds.envoyGateway.enabled=true \
  | kubectl apply --server-side -f -
```

2. Install gateway resources:
```
helm install eg oci://docker.io/envoyproxy/gateway-helm \
  --version v1.6.1 \
  -n envoy-gateway-system \
  --create-namespace \
  --skip-crds
```
Optional: (Use internal load balancer on cloud providers)
```
helm install eg oci://docker.io/envoyproxy/gateway-helm \
  --version v1.6.1 \
  -n envoy-gateway-system \
  --create-namespace \
  --skip-crds \
  --set service.type="LoadBalancer" \
  --set-string service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"="true"

```


Uninstall
```
helm uninstall eg -n envoy-gateway-system
```