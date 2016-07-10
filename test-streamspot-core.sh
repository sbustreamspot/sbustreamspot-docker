#!/usr/bin/env bash
set -eo pipefail

cd sbustreamspot-core
cat training/infoleak_small_units.CDM13.ss | \
  ./streamspot --edges=training/infoleak_small_units.CDM13.ss \
  --bootstrap=clusters/infoleak_small_units.CDM13.cl > ./test.json 2>/dev/null
ls
python compare_paas_json.py

if [ $? -ne 0 ]; then
  echo "[sbustreamspot-core] FAIL!"
  exit 1
else
  echo "[sbustreamspot-core] SUCCESS"
  exit 0
fi
