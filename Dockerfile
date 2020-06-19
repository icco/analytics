FROM golang:1.14-alpine

ENV GOPROXY="https://proxy.golang.org"
ENV GO111MODULE="on"
ENV NAT_ENV="production"

EXPOSE 8080

WORKDIR /go/src/github.com/zgoat/goatcounter

RUN apk add --no-cache git

RUN git clone --no-hardlinks -b release-1.3 https://github.com/zgoat/goatcounter.git .
RUN ls -al .
RUN go build \
#    -tags osusergo,netgo,sqlite_omit_load_extension \
#    -ldflags='-extldflags=-static' \
    -v -o /go/bin/goatcounter \
    ./cmd/goatcounter

RUN /go/bin/goatcounter -db $DATABASE_URL migrate all

CMD ["/go/bin/goatcounter", "-tls none", "-db $DATABASE_URL"]
