#!/bin/bash

for dump in dumps/*dump.json; do
  python3 manage.py loaddata "$dump"
done