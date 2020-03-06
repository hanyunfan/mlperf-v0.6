#!/bin/bash

## DL params
#MAX_TOKENS=10240
#MAX_TOKENS=15360
#MAX_TOKENS=20480 over 32G memory, may try on RTX8000
#MAX_TOKENS=18560 still too large
MAX_TOKENS=16000
LEARNING_RATE="1.976e-3"
WARMUP_UPDATES=1000
EXTRA_PARAMS="--max-source-positions 60 --max-target-positions 60 --enable-parallel-backward-allred-opt --parallel-backward-allred-opt-threshold 105404416 --parallel-backward-allred-cuda-nstreams 2 --adam-betas (0.9,0.98) "

## System run parms
DGXNNODES=1
DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME=02:00:00

## System config params
DGXNGPU=8
DGXSOCKETCORES=20
DGXNSOCKET=2
DGXHT=1         # HT is on is 2, HT off is 1
DGXIBDEVICES=''
