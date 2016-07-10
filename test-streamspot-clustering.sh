#!/usr/bin/env bash
set -eo pipefail

## Test StreamSpot clustering 
cd sbustreamspot-train
python create_seed_clusters.py --input ./test.sv > ./test.cl

if [ $? -ne 0 ]; then
  echo "[sbustreamspot-train] (clusters) FAIL!"
  exit 1
else
  echo "[sbustreamspot-train] (clusters) SUCCESS"
  exit 0
fi
