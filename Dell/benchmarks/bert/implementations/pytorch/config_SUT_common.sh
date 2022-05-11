## System config params
export DGXNGPU=2
export DGXSOCKETCORES=24
export DGXNSOCKET=1
export DGXHT=2         # HT is on is 2, HT off is 1
export SLURM_NTASKS=${DGXNGPU}
# export DGXHT=1
# export BIND_LAUNCH=1

## Data Paths
# export DATADIR="/mnt/data2/after_steps_bert_ds/2048_shards_uncompressed"
# export EVALDIR="/mnt/data2/after_steps_bert_ds/eval_set_uncompressed"
# export DATADIR_PHASE2="/mnt/data2/after_steps_bert_ds/2048_shards_uncompressed"
# export CHECKPOINTDIR="/mnt/data2/after_steps_bert_ds/cks"
# export CHECKPOINTDIR_PHASE1="/mnt/data2/after_steps_bert_ds/cks"
export DATADIR="/data/bert/hdf5/training-4320/hdf5_4320_shards_varlength"
export EVALDIR="/data/bert/hdf5/eval_varlength"
export DATADIR_PHASE2="/data/bert/hdf5/training-4320/hdf5_4320_shards_varlength"
export CHECKPOINTDIR_PHASE1="/data/bert/phase1"

export NCCL_SOCKET_IFNAME=
