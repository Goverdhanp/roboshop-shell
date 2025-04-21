source common.sh

print_head disble redis default version
dnf module disable redis -y &>> $log_file

print_head enable redis
dnf module enable redis:7 -y &>> $log_file

print_head enable redis
dnf install redis -y  &>> $log_file

print_head update redis config file
sed -i -e 's|12.0.0.1|0.0.0.0|' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>> $log_file

print_head start redis service
systemctl enable redis &>> $log_file
systemctl restart redis &>> $log_file