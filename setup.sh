#!/usr/local/env bash -ex

vagrant up --no-parallel

## Get data output from vaultclient
DATA="$(vagrant docker-logs vaultclient)"

## Get root token
ROOT_TOKEN=$(echo "$DATA" |grep -i 'root token' |awk -NF ': ' '{print$3}')

for POS in 1 2 3 ; do
  KEY_$POS=$(echo "$DATA" |grep -i $POS |awk -NF ': ' '{print$2}')
done

  export VAULT_ADDR=http://localhost:8200
  export VAULT_TOKEN=$ROOT_TOKEN

vault unseal $KEY_1
vault unseal $KEY_2
vault unseal $KEY_3

vault auth $ROOT_TOKEN
