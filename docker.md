# using kraken for private storage docker registry
https://github.com/uber/kraken
# show docker container ip address
docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'

# get docker host ip:
`$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')`

# install docker on centos
 - remove old docker
 `sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine`
 - install tools
  `sudo yum install -y yum-utils device-mapper-persistent-data lvm2`
 - add repo
  `sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo`
 - install docker ce
  `sudo yum install docker-ce docker-ce-cli containerd.io`
 - start docker engine
  `sudo systemctl start docker`

# add ping command to docker  (ubuntu)
apt-get update 
apt-get install iputils-ping

# run docker nodejs 11 
docker run --rm -it -v $(pwd):/src node:11-alpine sh

# merge multiple docekr-compose file
docker-compose -f file1.yml -f file2.yml ... config > all.yml

# rebuild docker image when using anonymous volume for node_modules
`docker-compose up --build -V`
this is neccessary because of not changing docker volume when up/down docker-compose service

# using composer directly
```
docker run --rm --interactive --tty --volume $PWD:/app composer install
```
# using 

# error when docker compose not access container 
expose container to compose file

# cleanup registry local (inside docker container)
```
cd /etc/docker/registry && registry garbage-collect config.yml
```