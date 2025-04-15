print_head(){
    echo -e "\e[31m$*\e[0m"

}

print_head Disable default nginx
dnf module disable nginx -y

print_head enable nginx 
dnf module enable nginx:1.24 -y

print_head install nginx
dnf install nginx -y

print_head copy  nginx conf
cp nginx.conf /etc/nginx/nginx.conf


print_head Clean olfd content

print_head Download app content
rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

cd /usr/share/nginx/html 

print_head Extract app content
unzip /tmp/frontend.zip

print_head Start nginx service
systemctl enable nginx 
systemctl restart nginx