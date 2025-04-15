echo -e "\e[35mDisable default nginx\e[0m"
dnf module disable nginx -y

echo -e "\e[36menable nginx 24\e[0m"
dnf module enable nginx:1.24 -y

echo -e "\e[35minstall nginx\e[0m"
dnf install nginx -y

echo -e "\e[34mcopy  nginx conf\e[0m"
cp nginx.conf /etc/nginx/nginx.conf


echo -e "\e[35mClean olfd contentx\e[0m"

echo -e "\e[35mDownload app content\e[0m"
rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

cd /usr/share/nginx/html 

echo -e "\e[34mExtract app content\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[32mStart nginx service\e[0m"
systemctl enable nginx 
systemctl restart nginx