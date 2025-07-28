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

# Performance improvement

## Use multiple stages

We should use multiple stages to build docker images
eg:
Original docker fie:
```bash
# Original Single-Stage Dockerfile
# This file serves as a comparison to demonstrate the improvements of multi-stage builds.

FROM node:20-alpine

WORKDIR /app

# Copy package.json and package-lock.json first to leverage caching
COPY package*.json ./

# Install ALL dependencies (including devDependencies)
# If you don't explicitly prune, npm install will install everything
RUN npm install

# Copy the rest of the application code
COPY . .

# If you have a build step, it would run here, generating temporary files
# and using build tools that won't be pruned from the final image.
# For example, if you were building a React app:
# RUN npm run build

EXPOSE 3000

CMD ["node", "index.js"]
```

Improved docker file:
```bash
# Stage 1: Build Stage - Install dependencies and build the application
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production # Use npm ci for clean installs, --only=production for smaller size

COPY . .

RUN npm run build # If you have a build step (e.g., React, Vue, Angular)

# Stage 2: Production Stage - Create a lean image with only the necessary files
FROM node:20-alpine AS production

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/dist ./dist # If you have a 'dist' folder from your build step
COPY --from=build /app/src ./src # Or whatever your source directory is for runtime
COPY --from=build /app/index.js ./index.js # Your main application file

EXPOSE 3000

CMD ["node", "index.js"]
```

## Use .dockerignore
To prevent unnecessary files from being copied into the Docker image, use a `.dockerignore` file

## Use docker build cache
Docker caches layers during the build process. If you change a file that is copied early in the Dockerfile, it will invalidate the cache for that layer and all subsequent layers. To optimize caching:
- Place frequently changing files (like source code) towards the end of the Dockerfile.
- Copy files that change less frequently (like `package.json`, `requirements.txt`, etc.) earlier in the Dockerfile. This allows Docker to cache the installation of dependencies, which is often time-consuming.
- Use specific COPY commands for files that change frequently, rather than copying the entire directory. This can help Docker cache layers more effectively.
- Use `docker build --no-cache` only when necessary, as it forces Docker to rebuild all layers without using the cache, which can significantly increase build time.
- For the ARG instruction, use it to pass build-time variables that can help in optimizing the build process. For example, you can use it to specify a version of a dependency that is less likely to change

**Note: ** If the ARG is changed, it will invalidate the cache for all subsequent layers, so use it wisely.