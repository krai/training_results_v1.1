## DL params
export BATCH_SIZE=71680
export DGXNGPU=8

export CONFIG="dgx_a100_8x8x1120.py"

## System run parms
export DGXNNODES=8
export DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
export WALLTIME=00:15:00
export OMPI_MCA_btl="^openib"
export MOUNTS=/raid:/raid
export CUDA_DEVICE_MAX_CONNECTIONS=3

export SBATCH_NETWORK=sharp
export SBATCH_OTHER_PARAMS="--switches 1@00:10:00"
