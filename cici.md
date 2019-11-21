# drone build docker image for cicd
FROM golang:1.11.13-alpine3.10 as builder
WORKDIR /app
ADD https://github.com/drone/drone/archive/v1.6.2.tar.gz v1.6.2.tar.gz
RUN tar xzf v1.6.2.tar.gz --strip-components=1 && rm v1.6.2.tar.gz
RUN apk add --update alpine-sdk 
RUN export GOPATH=/go
# RUN go install -tags "oss nolimit" github.com/drone/drone/cmd/drone-server
RUN go install github.com/drone/drone/cmd/drone-agent
RUN go install github.com/drone/drone/cmd/drone-controller
RUN go install github.com/drone/drone/cmd/drone-server


# image builded
FROM golang:1.11.13-alpine3.10
COPY --from=builder /go/bin/ /go/bin/
EXPOSE 8080
CMD [ "drone-server" ]
