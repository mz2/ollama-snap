#!/bin/bash
set -e

OLLAMA_HOST=$(snapctl get host)
OLLAMA_MODELS=$(snapctl get models)
OLLAMA_ORIGINS=$(snapctl get origins)
CUDA_VISIBLE_DEVICES_VALUE=$(snapctl get cuda-visible-devices)
OLLAMA_FLASH_ATTENTION=$(snapctl get flash-attention)
OLLAMA_DEBUG=$(snapctl get debug)
OPTIONAL_CONTEXT_LENGTH=$(snapctl get context-length)
OLLAMA_KEEP_ALIVE=$(snapctl get keep-alive)
OPTIONAL_LOAD_TIMEOUT=$(snapctl get load-timeout)
OPTIONAL_KV_CACHE_TYPE=$(snapctl get kv-cache-type)
OPTIONAL_NO_CLOUD=$(snapctl get no-cloud)
OPTIONAL_MAX_QUEUE=$(snapctl get max-queue)
OPTIONAL_MAX_LOADED_MODELS=$(snapctl get max-loaded-models)
OPTIONAL_NUM_PARALLEL=$(snapctl get num-parallel)

if [ -n "$CUDA_VISIBLE_DEVICES_VALUE" ]; then
    export CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES_VALUE
fi

if [ -n "$OPTIONAL_CONTEXT_LENGTH" ]; then
    export OLLAMA_CONTEXT_LENGTH=$OPTIONAL_CONTEXT_LENGTH
fi

if [ -n "$OLLAMA_KEEP_ALIVE" ]; then
    export OLLAMA_KEEP_ALIVE
fi

if [ -n "$OPTIONAL_LOAD_TIMEOUT" ]; then
    export OLLAMA_LOAD_TIMEOUT=$OPTIONAL_LOAD_TIMEOUT
fi

if [ -n "$OPTIONAL_KV_CACHE_TYPE" ]; then
    export OLLAMA_KV_CACHE_TYPE=$OPTIONAL_KV_CACHE_TYPE
fi

if [ -n "$OPTIONAL_NO_CLOUD" ]; then
    export OLLAMA_NO_CLOUD=$OPTIONAL_NO_CLOUD
fi

if [ -n "$OPTIONAL_MAX_QUEUE" ]; then
    export OLLAMA_MAX_QUEUE=$OPTIONAL_MAX_QUEUE
fi

if [ -n "$OPTIONAL_MAX_LOADED_MODELS" ]; then
    export OLLAMA_MAX_LOADED_MODELS=$OPTIONAL_MAX_LOADED_MODELS
fi

if [ -n "$OPTIONAL_NUM_PARALLEL" ]; then
    export OLLAMA_NUM_PARALLEL=$OPTIONAL_NUM_PARALLEL
fi

export OLLAMA_HOST OLLAMA_MODELS OLLAMA_ORIGINS OLLAMA_DEBUG
$SNAP/bin/ollama "$@"
