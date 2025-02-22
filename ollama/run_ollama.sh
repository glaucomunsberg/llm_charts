#!/bin/sh

set debuginfod enabled on
sudo service ollama stop
OLLAMA_MODELS=/mnt/Armazenamento/Projects/llm_charts/ollama/models OLLAMA_TMPDIR=/mnt/Armazenamento/Projects/llm_charts/ollama/tmp  OLLAMA_HOST="0.0.0.0" OLLAMA_ORIGINS="*" ollama serve