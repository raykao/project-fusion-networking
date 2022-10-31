export LOCATION="canadacentral"
export ADMIN_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)

az deployment sub create \
    --name "fusion-networking" \
    --location $LOCATION \
    --parameters @bicep/parameters.json \
    --parameters adminPublicKey="$ADMIN_PUBLIC_KEY" \
    --template-file bicep/deploy.bicep