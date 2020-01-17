#!/bin/bash

## DL params
OPTIMIZER="sgdwfastlars"
BATCHSIZE="208"
#BATCHSIZE="240"
KVSTORE="horovod"
#LR="5"
LR="6"
WARMUP_EPOCHS="5"
EVAL_OFFSET="3"
EVAL_PERIOD="4"
WD="0.0002"
LARSETA="0.001"
LABELSMOOTHING="0.1"
LRSCHED="pow2"
NUMEPOCHS="72"

NETWORK="resnet-v1b-normconv-fl"
export MXNET_CUDNN_SUPPLY_NORMCONV_CONSTANTS=1

DALI_PREFETCH_QUEUE="8"
DALI_NVJPEG_MEMPADDING="256"
DALI_CACHE_SIZE="0"
DALI_ROI_DECODE="1"  #needs to be set to 1 as default and proof perf uplift
#DALI_PREFETCH_QUEUE="3"
#DALI_CACHE_SIZE=6144


## Environment variables for multi node runs
## TODO: These are settings for large scale runs that
## may need to be adjusted for single node.
export HOROVOD_CYCLE_TIME=0.1
export HOROVOD_FUSION_THRESHOLD=67108864
export HOROVOD_NUM_STREAMS=2
export MXNET_HOROVOD_NUM_GROUPS=20
export NHWC_BATCHNORM_LAUNCH_MARGIN=32
export MXNET_EXEC_BULK_EXEC_MAX_NODE_TRAIN_FWD=999
export MXNET_EXEC_BULK_EXEC_MAX_NODE_TRAIN_BWD=25

## System run parms
DGXNNODES=1
DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME=03:00:00

## System config params
DGXNGPU=4
DGXSOCKETCORES=20
DGXHT=1         # HT is on is 2, HT off is 1
DGXIBDEVICES=''


export NCCL_SOCKET_NTHREADS=2
export NCCL_NSOCKS_PERTHREAD=8

