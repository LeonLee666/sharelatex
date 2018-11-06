echo "Starting sharelatex docker container"
SHARELATEX_ADMIN_EMAIL="liliangneu@yeah.net"
PORT=7000
docker run -d --name sharemongo -e AUTH=no tutum/mongodb
docker run -d --name shareredis -v /var/redis:/var/lib/redis redis
docker run -d -P -p $PORT:80 -v /var/sharelatex_data:/var/lib/sharelatex --env SHARELATEX_MONGO_URL=mongodb://mongo/sharelatex --env SHARELATEX_REDIS_HOST=redis --env SHARELATEX_ADMIN_EMAIL=$SHARELATEX_ADMIN_EMAIL --link sharemongo:mongo --link shareredis:redis --name sharelatex sharelatex/sharelatex

#install some extra packages (float, etc..)
docker exec sharelatex /bin/bash -c "sudo apt-get update"
docker exec sharelatex /bin/bash -c "sudo apt-get -y install texlive-generic-extra"
docker exec sharelatex /bin/bash -c "sudo apt-get -y install texlive-full"

docker exec sharelatex /bin/bash -c "cd /var/www/sharelatex/; grunt user:create-admin --email $SHARELATEX_ADMIN_EMAIL" &&  echo "Installed sharelatex" || echo "Failed to install the sharelatex container"

