#!/bin/bash

## DL params
EXTRA_PARAMS=""
EXTRA_CONFIG=(
               "SOLVER.BASE_LR"       "0.0225"
               "SOLVER.MAX_ITER"      "160000"
               "SOLVER.WARMUP_FACTOR" "0.000036"
               "SOLVER.WARMUP_ITERS"  "625"
               "SOLVER.WARMUP_METHOD" "mlperf_linear"
               "SOLVER.STEPS"         "(64000, 85333)"
               "SOLVER.IMS_PER_BATCH"  "18"
               "TEST.IMS_PER_BATCH" "3"
               "MODEL.RPN.FPN_POST_NMS_TOP_N_TRAIN" "6000"
               "NHWC" "True"   
             )

## System run parms
DGXNNODES=1
DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME=14:00:00

## System config params
DGXNGPU=3
DGXSOCKETCORES=32
DGXNSOCKET=2
DGXHT=1         # HT is on is 2, HT off is 1
DGXIBDEVICES=''
BIND_LAUNCH=0
