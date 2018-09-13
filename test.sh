#!/bin/bash

# Functions
ok() { echo -e '\e[32m'$1'\e[m'; } # Green

EXPECTED_ARGS=0
E_BADARGS=65
#MYSQL=`mysql`

VUSER="webuser"
VUPASS="webuser1@"
 
Q1="SET NAMES utf8;SET SQL_MODE='';SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0;CREATE DATABASE  IF NOT EXISTS bc DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
Q2="GRANT ALL ON *.* TO '${VUSER}'@'localhost' IDENTIFIED BY '${VUUPASS}';"
Q3="FLUSH PRIVILEGES;"

T1="CREATE TABLE action_logs ("
T2="user_id int(10) unsigned NOT NULL,"
T3="table_id int(10) unsigned NOT NULL,"
T4="round_num int(10) unsigned NOT NULL,"
T5="type enum('r','b','s','i','f','m') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'r: Regular, b: Bonus, s: Super 6, i: Insurance, f: flippy',"
T6="actions json DEFAULT NULL,"
T7="ip varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,"
T8="created_at datetime DEFAULT NULL,"
T9="PRIMARY KEY (user_id,table_id,round_num)"
T11=") ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;"
Q4="USE bc;${T1}${T2}${T3}${T4}${T5}${T6}${T7}${T8}${T9}${T11}"

SQL="${Q1}${Q2}${Q3}${Q4}"
 
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi
/etc/init.d/mysql start
mysql -uroot -pbfd3v3l0p3r1@ -e "$SQL"

ok "Database  and user created with a password "
