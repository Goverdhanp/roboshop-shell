systemd_setup(){
print_head copy the sytemd service file
cp $pwd/$component.service /etc/systemd/system/$component.service &>> $log_file
systemctl daemon-reload &>> $log_file
systemctl enable $component  &>> $log_file
systemctl restart $component &>> $log_file
}


artifact_download(){
    print_head add applicatioin user
    id roboshop &>> $log_file
    if [ $? -ne 0 ] ; then
        useradd roboshop &>> $log_file
    fi
    exit_status_print $?
    
    print_head remove existing aplication code
    rm -rf /app &>> $log_file
    exit_status_print $?
    
    print_head create application directory
    mkdir /app  &>> $log_file
    exit_status_print $?
    
    print_head download application content
    curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip &>>$log_file
    exit_status_print $?
    cd /app 
    
    print_head extract application content
    unzip /tmp/catalogue.zip &>>$log_file
    exit_status_print $?

    
}
  

nodejs_app_setup(){
    print_head disable default nodejs version
    dnf module disable nodejs -y &>> $log_file
    exit_status_print $?

    print_head enable nodejs 20
    dnf module enable nodejs:20 -y &>> $log_file
    exit_status_print $?
    

    print_head install nodejs 20
    dnf install nodejs -y &>> $log_file
    exit_status_print $?

 
    artifact_download
    cd /app 

    print_head install nodejs dependencies
    npm install  &>> $log_file
    exit_status_print $?


    systemd_setup
}

maven_app_setup(){
    dnf install maven -y &>> $log_file
    
    artifact_download
    cd /app 

    print_head install maven dependencies
    mvn clean package  &>> $log_file
    mv target/$component-1.0.jar $component.jar &>> $log_file

    systemd_setup
}

python_app_setup(){
    print_head install python packages
    dnf install python3 gcc python3-devel -y &>> $log_file

    artifact_download
    cd /app         

    print_head install python dependencies
    pip3 install -r requirements.txt &>> $log_file

    systemd_setup
}

print_head(){
    echo -e "\e[31m$*\e[0m"
    echo "#################################" &>> $log_file
    echo -e "\e[31m$*\e[0m"&>> $log_file
    echo "#################################" &>> $log_file

}

log_file=/tmp/roboshop.log
rm -f $log_file

exit_status_print(){
    if [ $? -eq 0 ]; then
            echo -e "\e[32m >> SUCESS\e[0m"
        else
            echo -e "\e[31m >> FAILURE\e[0m"

            lno=$(cat -n /tmp/roboshop.log | grep '#################################' | tail -n 2 | head -n 1 | awk '{print $1}')
            echo
            echo
            sed -n -e "$lno, $ p" /tmp/roboshop.log
            echo
            exit 1
    fi
    
    }


pwd=$(pwd)