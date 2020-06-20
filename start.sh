#!/bin/sh

set -ex

/go/bin/goatcounter migrate all -db $DATABASE_URL

/go/bin/goatcounter -tls none -db $DATABASE_URL
