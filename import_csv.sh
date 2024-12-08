#!/bin/bash

docker exec -i "sae-dolibarr_mariadb_1" mariadb -u "root" -p"root" -e "USE dolidb;\
LOAD DATA INFILE '/home/csv/import.csv'
    INTO TABLE llx_societe
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (rowid,nom,entity,status,address,zip,town,fk_pays,phone,email,tms);"