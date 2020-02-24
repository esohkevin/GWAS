#!/usr/bin/env bash

seq 5 -1 2 | parallel echo -m camparams{} -e extraparams_noadm -K {} | xargs -P5 -n6 structure

#seq 5 15 | parallel echo -m worldparams{} -e extraparams -K {} | xargs -P5 -n6 structure

