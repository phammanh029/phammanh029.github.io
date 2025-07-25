# This contains Ory related setup/info

## List oauth2-clients

```bash
ory list oauth2-clients --project <project id>
```

## Get Ory Oauth config:

```bash
ory get oauth2-client  --project <project id> <client id> --format json | jq
```

## Path oauth client scope

```bash
curl --location --request PATCH 'https://<slug>.projects.oryapis.com/admin/clients/<client id>' \
--header 'Authorization: Bearer <Api key>' \
--header 'Content-Type: application/json' \
--data '[
    {
        "from": "/scope",
        "op": "replace",
        "path": "/scope",
        "value": "<new scopes>"
    }
]'
```

## Update project jwt config

```bash
ory patch project <project id> \
  --add '/services/oauth2/config/token/profiles/-={"name":"jwt_default","claims":{"sub":"{{ .Identity.ID }}","email":"{{ .Identity.Traits.email }}"}}'
```
Example of patch `jwt_default`:
```bash
ory create jwk some-example-set \
  --alg ES256 --project <project id> --format json-pretty \
  > es256.jwks.json

JWKS_B64_ENCODED=$(cat es256.jwks.json | base64 -w 0)
JSONNET_B64_ENCODED=$(cat claims.jsonnet | base64 -w 0)

ory patch identity-config --project <project id> --workspace <workspace id> \
  --add '/session/whoami/tokenizer/templates/jwt_default={"jwks_url":"base64://'$JWKS_B64_ENCODED'","claims_mapper_url":"base64://'$JSONNET_B64_ENCODED'","ttl":"10m"}' \
  --format yaml
```