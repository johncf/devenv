#!/bin/bash

PASS_LENGTH=${1:-15}

for p in $(seq 1 5); do
    openssl rand -base64 48 | cut -c1-$PASS_LENGTH
done
