#!/bin/bash
docker kill sae-dolibarr_web_1
docker kill sae-dolibarr_mariadb_1
docker rm sae-dolibarr_web_1
docker rm sae-dolibarr_mariadb_1

sudo rm -rf ./dolibarr_custom/ ./dolibarr_documents/ ./dolibarr_mariadb/