#!/usr/bin/env bash
set -eo pipefail

cd sbustreamspot-cdm
python translate_cdm_to_streamspot.py --url avro/infoleak_small_units.CDM13.avro \
  --format avro --source file > ./test.ss
diff -u ./test.ss streamspot/infoleak_small_units.CDM13.ss > ./diff

if [ -s ./diff ]; then
  echo "[sbustreamspot-cdm] FAIL!"
  exit 1
else
  echo "[sbustreamspot-cdm] SUCCESS"
  exit 0
fi
