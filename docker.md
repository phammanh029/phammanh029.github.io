# using kraken for private storage docker registry
https://github.com/uber/kraken
# show docker container ip address
docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'
