# Overview

# Usages
## Wildcard domains handler with 1 single private link

We can setup frontdoor wildcard by set wildcard domain and it's root domain to the same frontdoor endpoint. On the origin, set the host to the root domain, the host header should be empty, then frontdoor will forward the request to origin with the correct host header.