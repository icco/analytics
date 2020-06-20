#!/bin/sh

set -ex

/go/bin/goatcounter migrate -db $DATABASE_URL all

/go/bin/goatcounter -tls none -db $DATABASE_URL
