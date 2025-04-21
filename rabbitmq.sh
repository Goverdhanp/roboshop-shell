source common.sh
print_head copy rabbitMq repo file
cp rabbitmq.repo  /etc/yum.repos.d/rabbitmq.repo &>> $log_file

print_head install rabbitmq server
dnf install rabbitmq-server -y &>> $log_file

print_head start rabbitmq server
systemctl enable rabbitmq-server &>> $log_file
systemctl start rabbitmq-server &>> $log_file

print_head add application roboshop user
rabbitmqctl add_user roboshop roboshop123 &>> $log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $log_file

