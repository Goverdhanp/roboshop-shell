component = shipping
source common.sh
maven_app_setup

print_head install mysql clinet
dnf install mysql -y &>> $log_file

print_head load schema
mysql -h 172.31.14.173 -uroot -pRoboShop@1 < /app/db/schema.sql &>> $log_file

print_head load user creation
mysql -h 172.31.14.173 -uroot -pRoboShop@1 < /app/db/app-user.sql &>> $log_file

print_head load Master Data
mysql -h 172.31.14.173 -uroot -pRoboShop@1 < /app/db/master-data.sql &>> $log_file
