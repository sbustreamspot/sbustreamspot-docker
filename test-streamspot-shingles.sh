#!/usr/bin/env bash
set -eo pipefail

## Test StreamSpot concise - shingle vectors translation
cd sbustreamspot-train
./graphs-to-shingle-vectors/streamspot --edges=./test.ss --chunk-length 24 > ./test.sv
diff -u ./test.sv shingles/infoleak_small_units.CDM13.sv > ./diff

if [ -s ./diff ]; then
  echo "[sbustreamspot-train] (shingles) FAIL!"
  exit 1
else
  echo "[sbustreamspot-train] (shingles) SUCCESS"
  exit 0
fi
