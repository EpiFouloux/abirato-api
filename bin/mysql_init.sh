GREEN='\033[0;32m'
NC='\033[0m'
echo -e "${GREEN} -- Creating mysqld folder${NC}"
sudo mkdir /var/run/mysqld
echo -e "${GREEN} -- Creating mysqld.pid and mysqld.sock${NC}"
sudo touch /var/run/mysqld/{mysqld.pid,mysqld.sock}
echo -e "${GREEN} -- Changing mysqld folder rights${NC}"
sudo chown mysql:mysql -R /var/run/mysqld
echo -e "${GREEN} -- Restarting mysqld service${NC}"
sudo service mysql restart