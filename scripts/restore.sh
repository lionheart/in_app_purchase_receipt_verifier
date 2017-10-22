#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Please provide an archive name from the list below. Please wait."
    tarsnap --list-archives --keyfile ~/.tarsnap/in_app_purchase_receipt_verifier-tarsnap.key | sort
    exit
fi

if [ -e $1/schema.sql ]; then
    echo "Archive already downloaded. Using cached copy."
else
    mkdir $1
    tarsnap -x --keyfile ~/.tarsnap/in_app_purchase_receipt_verifier-tarsnap.key -f $1 -C $1
fi

dropdb in_app_purchase_receipt_verifier_local
createdb in_app_purchase_receipt_verifier_local -O in_app_purchase_receipt_verifier_local
export PGOPTIONS='--client-min-messages=warning'
psql --pset pager=off --quiet -U in_app_purchase_receipt_verifier_local in_app_purchase_receipt_verifier_local < $1/schema.sql
psql --pset pager=off --quiet -U in_app_purchase_receipt_verifier_local in_app_purchase_receipt_verifier_local < $1/data.sql

