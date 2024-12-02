mkdir csv
mysql -h 172.20.0.2 -u dolidbuser -pdolidbpass dolidb -e "SELECT * INTO OUTFILE '/csv/export.csv', FIELDS TERMINATED BY ',', ENCLOSED BY '', LINES TERMINATED BY '\n', FROM llx_societe;"