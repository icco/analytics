#!/bin/sh

set -ex

/go/bin/goatcounter migrate -db $DATABASE_URL all

/go/bin/goatcounter serve -port 8080 -tls none -db $DATABASE_URL
