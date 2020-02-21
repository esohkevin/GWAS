#!/usr/bin/env bash

seq 5 -1 2 | parallel echo -m camparams -e extraparams -K {} | xargs -P3 -n6 structure
