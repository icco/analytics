FROM golang:1.14-alpine

ENV GOPROXY="https://proxy.golang.org"
ENV GO111MODULE="on"
ENV NAT_ENV="production"

EXPOSE 8080

WORKDIR /go/src/zgo.at/goatcounter/

COPY ./start.sh /go/bin/

RUN apk add --no-cache git gcc ca-certificates g++ build-base bash

RUN git clone --no-hardlinks https://github.com/zgoat/goatcounter.git .
RUN git checkout release-1.3
RUN go build \
    -tags osusergo,netgo,sqlite_omit_load_extension \
    -ldflags='-extldflags=-static' \
    -v -o /go/bin/goatcounter \
    ./cmd/goatcounter

CMD /go/bin/start.sh
