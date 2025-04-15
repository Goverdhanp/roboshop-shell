
component = shipping
source common.sh
maven_app_setup

dnf install mysql -y

mysql -h 172.31.14.173 -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h 172.31.14.173 -uroot -pRoboShop@1 < /app/db/app-user.sql 
mysql -h 172.31.14.173 -uroot -pRoboShop@1 < /app/db/master-data.sql
