az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}"
az account set --subscription="${SUBSCRIPTION_ID}"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
az ad sp create-for-rbac -n "MyApp" --role contributor \
    --scopes /subscriptions/{SubID}/resourceGroups/{ResourceGroup1} \
    /subscriptions/{SubID}/resourceGroups/{ResourceGroup2}

    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/4cedc5dd-e3ad-468d-bf66-32e31bdb9148/resourceGroups/1-e5414e-playground-sandbox"

    