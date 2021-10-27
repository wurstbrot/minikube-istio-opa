#!/bin/bash
set -e

rm /tmp/tmptext || true
echo "generating data.json file"
for i in in {1..10000000}; do
  echo "Some text${i}" >>/tmp/tmptext
done
echo "{\"key\": \"$(cat /tmp/tmptext | base64 -w 0)\"}" > data.json
ls -lah data.json
