systemctl start docker

rm -rf invidious
rm -rf teddit
rm -rf nitter
rm -rf FreshRSS
rm -rf bibliogram
rm -rf etc-pihole
rm -rf etc-dnsmasq.d
rm -f .env


git clone https://github.com/iv-org/invidious.git
git clone https://github.com/teddit-net/teddit.git
git clone https://github.com/zedeus/nitter.git
git clone https://github.com/FreshRSS/FreshRSS.git
git clone https://git.sr.ht/~cadence/bibliogram

read -p "enter IP address:" IPADDR
read -p "enter domain name:" DOMAINNAME
export COMPOSE_HTTP_TIMEOUT=660
export IPADDR=$IPADDR
export DOMAINNAME=$DOMAINNAME

touch .env
echo "IPADDR=$IPADDR" >> .env
echo "DOMAINNAME=$DOMAINNAME" >> .env



sed -i "s/localhost:10407/bibliogram.$DOMAINNAME/g" bibliogram/src/lib/constants.js

docker-compose build

docker-compose down

docker-compose up -d


