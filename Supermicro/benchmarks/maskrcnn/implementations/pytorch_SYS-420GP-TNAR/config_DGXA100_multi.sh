# network flag to enable SHARP
export SBATCH_NETWORK=sharp

## DL params
: "${ENABLE_DALI:=False}"
: "${USE_CUDA_GRAPH:=True}"
: "${CACHE_EVAL_IMAGES:=True}"
: "${EVAL_SEGM_NUMPROCS:=10}"
: "${EVAL_MASK_VIRTUAL_PASTE:=True}"
: "${INCLUDE_RPN_HEAD:=True}"
: "${PRECOMPUTE_RPN_CONSTANT_TENSORS:=True}"
: "${DATALOADER_NUM_WORKERS:=2}"
: "${HYBRID_LOADER:=True}"
: "${NUM_GRAPHS:=1}"
: "${DISABLE_LOSS_LOGGING:=False}"
: "${FUSED_SGD_DEBUG_PRINTS:=False}"
: "${SOLVER_MAX_ITER:=20000}"

export BATCHSIZE=1
export EXTRA_PARAMS=""
export EXTRA_CONFIG='SOLVER.BASE_LR 0.24 SOLVER.WARMUP_FACTOR 0.000133 SOLVER.WARMUP_ITERS 1800 SOLVER.WARMUP_METHOD mlperf_linear SOLVER.STEPS (5294,7058) SOLVER.IMS_PER_BATCH 272 TEST.IMS_PER_BATCH 272 MODEL.RPN.FPN_POST_NMS_TOP_N_TRAIN 1000 MODEL.RPN.FPN_POST_NMS_TOP_N_PER_IMAGE True NHWC True MODEL.RESNETS.FIRST_TRANS_FUNC FastBottleneckWithFixedBatchNorm MODEL.RESNETS.TRANS_FUNC FastBottleneckWithFixedBatchNorm'
export EXTRA_CONFIG="${EXTRA_CONFIG} SOLVER.MAX_ITER ${SOLVER_MAX_ITER} DATALOADER.DALI $ENABLE_DALI DATALOADER.DALI_ON_GPU $ENABLE_DALI DATALOADER.CACHE_EVAL_IMAGES $CACHE_EVAL_IMAGES EVAL_SEGM_NUMPROCS $EVAL_SEGM_NUMPROCS USE_CUDA_GRAPH $USE_CUDA_GRAPH EVAL_MASK_VIRTUAL_PASTE $EVAL_MASK_VIRTUAL_PASTE MODEL.BACKBONE.INCLUDE_RPN_HEAD $INCLUDE_RPN_HEAD DATALOADER.NUM_WORKERS $DATALOADER_NUM_WORKERS PRECOMPUTE_RPN_CONSTANT_TENSORS $PRECOMPUTE_RPN_CONSTANT_TENSORS DATALOADER.HYBRID $HYBRID_LOADER CUDA_GRAPH_NUM_SHAPES_PER_ORIENTATION $NUM_GRAPHS DISABLE_LOSS_LOGGING $DISABLE_LOSS_LOGGING FUSED_SGD_DEBUG_PRINTS $FUSED_SGD_DEBUG_PRINTS"

## System run parms
export DGXNNODES=34
export DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME_MINUTES=30
export WALLTIME=$((${NEXP} * ${WALLTIME_MINUTES}))

## System config params
export DGXNGPU=8
export DGXSOCKETCORES=64
export DGXNSOCKET=2
export DGXHT=2 	# HT is on is 2, HT off is 1
