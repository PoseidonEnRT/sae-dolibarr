#!/bin/bash
mkdir dolibarr_mariadb
mkdir dolibarr_documents
mkdir dolibarr_custom

sudo docker-compose up -d

mkdir backup

(crontab -l 2>/dev/null ; echo "0 * * * * ./save.sh") | crontab -