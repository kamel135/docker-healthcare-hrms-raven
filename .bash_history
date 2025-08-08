ls
tree -L 4
cd ~
rm -rf *
rm -rf .*
rm -rf frappe_docker
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker volume prune -f
docker rmi $(docker images -q) --force
docker network prune -f
rm -rf create-site-portal/venv
مس
ls
git clone https://github.com/Avunu/frappe-bench-docker.git
ls
exit
reboot
rebot
reboat
ps aux | awk '$8 ~ /Z/ { print $0 }'
ps -o ppid= -p 1203186
ps -fp 1203185
systemctl status nginx | less
sudo kill 1203185
sudo reboot
ls
sudo su
su -
reboot
su -
su -
sudo usermod -aG sudo kamel
ls
cd frappe-bench-docker
echo $PS1
nano ~/.bashrc
source ~/.bashrc
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc && source ~/.bashrc
nano ~/.bashrc
source ~/.bashrc
clear
ls
./setup.sh
chmod +x setup.sh
./setup.sh
./bench.sh "new-site run.edenmea.com"
chmod +x bench.sh
./bench.sh "new-site run.edenmea.com"
docker exec -it frappe-bench-docker-backend-1 bash
cd ~/frappe-bench-docker
docker compose down
rm -rf frappe-bench mariadb-data .env cupsd.conf printers.conf .configured
rm -rf frappe-bench mariadb-data .env cupsd.conf printers.conf .configured
rm -rf .env* frappe-bench mariadb-data vendor cupsd.conf printers.conf .configured *.sh *.ps1 docker-compose.yml Caddyfile README.md LICENSE CONTRIBUTING.md
docker ps -a
docker volume prune -f
docker volume ls | grep frappe | awk '{print $2}' | xargs docker volume rm
echo $PS1
nano ~/.bashrc
cd ../
ls
rm -rf ~/frappe-bench-docker
ls -la ~
ks
ls
echo $PS1
nano ~/.bashrc
source ~/.bashrc
ls -la
clear
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
ls
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
source ~/.bashrc
clear
ls
nano apps.json
export APPS_JSON_BASE64=$(base64 -w 0 apps.json )
echo ${APPS_JSON_BASE64}
echo -n ${APPS_JSON_BASE64} | base64 -d > apps-test-output.json
ls
cat apps
cat apps-test-output.json 
jq empty apps.json
git clone https://github.com/frappe/frappe_docker
cd frappe_docker
docker build   --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe   --build-arg=FRAPPE_BRANCH=version-15   --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64   --tag=ghcr.io/user/repo/custom:1.0.0   --file=images/layered/Containerfile .
docker images
docker tag ghcr.io/user/repo/custom:1.0.0 frappe-custom
docker images
docker login
docker push frappe-custom
docker tag frappe-custom kamel197/frappe-custom:latest
docker images
docker push kamel197/frappe-custom
cat pwd.yml 
nano pwd.yml 
nano pwd.yml 
nano pwd.yml 
nano pwd.yml 
cat pwd.yml 
nano pwd.yml 
nano pwd.yml 
cat pwd.yml 
docker compose -f pwd.yml up -d
cat pwd.yml 
:
      restart_policy:
        condition: none
    entrypoint:
      - bash
      - -c
    command:
      - >
        ls -1 apps > sites/apps.txt;
        bench set-config -g db_host $$DB_HOST;
        bench set-config -gp db_port $$DB_PORT;
        bench set-config -g redis_cache "redis://$$REDIS_CACHE";
        bench set-config -g redis_queue "redis://$$REDIS_QUEUE";
        bench set-config -g redis_socketio "redis://$$REDIS_QUEUE";
        bench set-config -gp socketio_port $$SOCKETIO_PORT;
    environment:
      DB_HOST: db
      DB_PORT: "3306"
      REDIS_CACHE: redis-cache:6379
      REDIS_QUEUE: redis-queue:6379
      SOCKETIO_PORT: "9000"
    volumes:
      - sites:/home/frappe/frappe-bench/sites
      - logs:/home/frappe/frappe-bench/logs
  create-site:
    image: kamel197/frappe-custom:latest
    networks:
      - frappe_network
    deploy:
      restart_policy:
        condition: none
    volumes:
      - sites:/home/frappe/frappe-bench/sites
      - logs:/home/frappe/frappe-bench/logs
    entrypoint:
      - bash
      - -c
    command:
      - >
        wait-for-it -t 120 db:3306;
        wait-for-it -t 120 redis-cache:6379;
        wait-for-it -t 120 redis-queue:6379;
        export start=`date +%s`;
        until [[ -n `grep -hs ^ sites/common_site_config.json | jq -r ".db_host // empty"` ]] &&           [[ -n `grep -hs ^ sites/common_site_config.json | jq -r ".redis_cache // empty"` ]] &&           [[ -n `grep -hs ^ sites/common_site_config.json | jq -r ".redis_queue // empty"` ]];         do           echo "Waiting for sites/common_site_config.json to be created";           sleep 5;           if (( `date +%s`-start > 120 )); then             echo "could not find sites/common_site_config.json with required keys";             exit 1;           fi;         done;
        echo "sites/common_site_config.json found";
        bench new-site --mariadb-user-host-login-scope='%' --admin-password=admin --db-root-username=root --db-root-password=admin --install-app erpnext --set-default frontend;
  db:
    image: mariadb:10.6
    networks:
      - frappe_network
    healthcheck:
      test: mysqladmin ping -h localhost --password=admin
      interval: 1s
      retries: 20
    deploy:
      restart_policy:
        condition: on-failure
    command:
      - --character-set-server=utf8mb4
      - --collation-server=utf8mb4_unicode_ci
      - --skip-character-set-client-handshake
      - --skip-innodb-read-only-compressed # Temporary fix for MariaDB 10.6
    environment:
      MYSQL_ROOT_PASSWORD: admin
      MARIADB_ROOT_PASSWORD: admin
    volumes:
      - db-data:/var/lib/mysql
  frontend:
    image: kamel197/frappe-custom:latest
    networks:
      - frappe_network
    depends_on:
      - websocket
    deploy:
      restart_policy:
        condition: on-failure
    command:
      - nginx-entrypoint.sh
    environment:
      BACKEND: backend:8000
      FRAPPE_SITE_NAME_HEADER: frontend
      SOCKETIO: websocket:9000
      UPSTREAM_REAL_IP_ADDRESS: 127.0.0.1
      UPSTREAM_REAL_IP_HEADER: X-Forwarded-For
      UPSTREAM_REAL_IP_RECURSIVE: "off"
      PROXY_READ_TIMEOUT: 120
      CLIENT_MAX_BODY_SIZE: 50m
    volumes:
      - sites:/home/frappe/frappe-bench/sites
      - logs:/home/frappe/frappe-bench/logs
    ports:
      - "8080:8080"
  queue-long:
    image: kamel197/frappe-custom:latest
    networks:
      - frappe_network
    deploy:
      restart_policy:
        condition: on-failure
    command:
      - bench
      - worker
      - --queue
      - long,default,short
    volumes:
      - sites:/home/frappe/frappe-bench/sites
      - logs:/home/frappe/frappe-bench/logs
  queue-short:
    image: kamel197/frappe-custom:latest
    networks:
      - frappe_network
    deploy:
      restart_policy:
        condition: on-failure
    command:
      - bench
      - worker
      - --queue
      - short,default
    volumes:
      - sites:/home/frappe/frappe-bench/sites
      - logs:/home/frappe/frappe-bench/logs
  redis-queue:
    image: redis:6.2-alpine
    networks:
      - frappe_network
    deploy:
      restart_policy:
        condition: on-failure
ls
cd frappe_docker/
ls
cat pwd.yml 
sudo apt update
sudo apt install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo nano /etc/nginx/sites-available/run.edenmea.com
sudo ln -s /etc/nginx/sites-available/run.edenmea.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d run.edenmea.com
sudo nano /etc/nginx/sites-available/run.edenmea.com
sudo certbot certonly --nginx -d run.edenmea.com
sudo cat /etc/nginx/sites-available/run.edenmea.com
sudo nano /etc/nginx/sites-available/run.edenmea.com
sudo systemctl stop nginx
sudo certbot --nginx -d run.edenmea.com
sudo nginx -t
sudo systemctl restart nginx
sudo grep -r "run.edenmea.com" /etc/nginx/
sudo systemctl status nginx.service
sudo lsof -i :80
sudo lsof -i :443
sudo systemctl stop nginx
sudo kill -9 47869
sudo kill -9 47895
sudo kill -9 47896
sudo lsof -i :80
sudo lsof -i :443
sudo systemctl restart nginx
sudo systemctl status nginx
ls -la
source ~.bashrc
source ~./bashrc
./source ~./bashrc
source ~/.bashrc
clear
docker compose -f pwd.yml down
cd frappe_docker/
docker compose -f pwd.yml down
docker compose -f pwd.yml down -v
nano pwd.yml
cat pwd.yml 
docker compose -f pwd.yml up -d
docker logs frappe_docker-create-site-1 -f
sudo netstat -tuln | grep '80\|443'
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
ؤشؤشyrd
ls
cd frappe_docker/
cd 
sudo apt install ufw
sudo ufw allow OpenSSH
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
sudo nano /etc/ssh/sshd_config
sudo ufw allow from 172.210.64.11 to any port 22
ls
./source ~./bashrc
source ~/.bashrc
clear
ls
