#!/usr/bin/env bash
set -eo pipefail

## Test Avro - StreamSpot concise translation
cd sbustreamspot-cdm
python translate_cdm_to_streamspot.py \
  --url ./avro/infoleak_small_units.CDM13.avro \
  --format avro --source file --concise > ../sbustreamspot-train/test.ss

cd ../sbustreamspot-train
diff -u ./test.ss streamspot/infoleak_small_units.CDM13.ss

if [ -s ./diff ]; then
  echo "[sbustreamspot-train] (ss) FAIL!"
  exit 1
else
  echo "[sbustreamspot-train] (ss) SUCCESS"
  exit 0
fi
