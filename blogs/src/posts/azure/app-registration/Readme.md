# Overview

This document provides a comprehensive guide on how to register an application in Azure Active Directory (Azure AD). Application registration is a crucial step for enabling your application to integrate with Azure AD and utilize its authentication and authorization capabilities.


# Create app registration with Azure CLI

```bash
SUB_ID=$(az group show -n cl-manh-pham-rg --query id -o tsv | cut -d'/' -f3)
echo "SUB_ID=$SUB_ID"

# Variables (edit)
STATE_RG="<your resource group>"
STATE_SA="tfstateaccount"     # storage account for tfstate
STATE_CONTAINER="tfstate"
DEPLOY_SCOPE="/subscriptions/$SUB_ID"   # or /subscriptions/$SUB_ID/resourceGroups/<rg-name>

# 1) Create SP with a client secret
az ad sp create-for-rbac \
  --name "sp-terraform" \
  --role "Contributor" \
  --scopes "$DEPLOY_SCOPE" \
  --sdk-auth false \
  --years 1
# Capture the output values:
#   appId  => ARM_CLIENT_ID
#   tenant => ARM_TENANT_ID
#   password => ARM_CLIENT_SECRET
#   (subscriptionId you already have)
```
