#!/usr/bin/env bash

# This uses the documentation from HashiCorp to work with Vault Leases for tokens.
# https://www.vaultproject.io/api/system/leases.html

# Authenticate to Vault #

#export VAULT_TOKEN=$(vault login -method=ldap username -field "client_token" -format "json")

# Check top level of Leases tree #


echo "# Top Level #"
curl -s\
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request LIST \
    $VAULT_ADDR/v1/sys/leases/lookup | jq


echo "# List all of the Accessors of the Tokens #"
curl -s\
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request LIST \
    $VAULT_ADDR/v1/sys/leases/lookup/auth/token/create
curl -s\
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request LIST \
    $VAULT_ADDR/v1/sys/leases/lookup/auth/token/create >> token_accessors.json

echo "Found the following accessors, you can put them in a payload.json."
cat token_accessors.json | jq -r '.data.keys'

export ACCESSOR_ARRAY=$(cat token_accessors.json | jq -r '.data.keys')

# Convert ACCESSOR_ARRAY from JSON to something Bash can work with

echo "${ACCESSOR_ARRAY}" | jq -r '.[]'
export ACCESSOR_TEXT_LIST=$(echo ${ACCESSOR_ARRAY} | jq -r '.[]')
echo accessor text list is $ACCESSOR_TEXT_LIST

echo "Look up the Token Creation Time"

for ACCESSOR in $(echo $ACCESSOR_ARRAY > jq -r '.[]')
do
printf "Creation time for Accessor: {\"lease_id\": \"auth/token/create/$ACCESSOR\"} was "
curl -s \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request PUT \
    --data "{\"lease_id\": \"auth/token/create/$ACCESSOR\"}" \
    $VAULT_ADDR/v1/sys/leases/lookup | jq  -r '.data.issue_time'
done
