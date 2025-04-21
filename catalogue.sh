component = catalogue
source common.sh

print_head copy mognodb repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $log_file
echo $?
nodejs_app_setup 

print_head install mongoDB
dnf install mongodb-mongosh -y &>> $log_file
echo $?

print_head load master data
mongosh --host mongo-dev.gvndevops12.tech </app/db/master-data.js &>> $log_file
echo $?