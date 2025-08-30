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

if [ -n "$CUDA_VISIBLE_DEVICES_VALUE" ]; then
    export CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES_VALUE
fi

if [ -n "$OPTIONAL_CONTEXT_LENGTH" ]; then
    export OLLAMA_CONTEXT_LENGTH=$OPTIONAL_CONTEXT_LENGTH
fi

export OLLAMA_HOST OLLAMA_MODELS OLLAMA_ORIGINS OLLAMA_DEBUG
$SNAP/bin/ollama "$@"
