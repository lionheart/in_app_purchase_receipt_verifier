#!/usr/bin/env bash

pip3 install virtualenv
gem install bundler
virtualenv venv
source venv/bin/activate

pip3 install -r requirements.txt
bundle install

ln -s conf/settings/local.py local_settings.py

createuser -s `whoami`
createdb -O `whoami` `whoami`

psql << EOF
CREATE ROLE in_app_purchase_receipt_verifier_local WITH LOGIN ENCRYPTED PASSWORD 'in_app_purchase_receipt_verifier_local';
CREATE DATABASE in_app_purchase_receipt_verifier_local WITH OWNER in_app_purchase_receipt_verifier_local;
EOF

chmod +x manage.py
./manage.py migrate
