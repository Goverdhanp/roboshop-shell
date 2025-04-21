source common.sh

print_head install mysql server
dnf install mysql-server -y &>> $log_file

print_head start mysql server
systemctl enable mysqld &>> $log_file

systemctl start mysqld  
print_head set up root password &>> $log_file

mysql_secure_installation --set-root-pass RoboShop@1 &>> $log_file