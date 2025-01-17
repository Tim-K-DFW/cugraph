#!/bin/bash
# Copyright (c) 2023, NVIDIA CORPORATION.
#
# Usage: bash apply_wheel_modifications.sh <new_version> <cuda_suffix>

VERSION=${1}
CUDA_SUFFIX=${2}

# __init__.py updates
sed -i "s/__version__ = .*/__version__ = \"${VERSION}\"/g" \
  python/cugraph/cugraph/__init__.py \
  python/cugraph-dgl/cugraph_dgl/__init__.py \
  python/cugraph-pyg/cugraph_pyg/__init__.py \
  python/cugraph-service/client/cugraph_service_client/__init__.py \
  python/cugraph-service/server/cugraph_service_server/__init__.py \
  python/pylibcugraph/pylibcugraph/__init__.py

# setup.py updates
sed -i "s/^version = .*/version = \"${VERSION}\"/g" \
  python/cugraph/pyproject.toml \
  python/cugraph-dgl/pyproject.toml \
  python/cugraph-pyg/pyproject.toml \
  python/cugraph-service/client/pyproject.toml \
  python/cugraph-service/server/pyproject.toml \
  python/pylibcugraph/pyproject.toml

# pylibcugraph pyproject.toml cuda suffixes
sed -i "s/name = \"pylibcugraph\"/name = \"pylibcugraph${CUDA_SUFFIX}\"/g" python/pylibcugraph/pyproject.toml
sed -i "s/rmm/rmm${CUDA_SUFFIX}/g" python/pylibcugraph/pyproject.toml
sed -i "s/pylibraft/pylibraft${CUDA_SUFFIX}/g" python/pylibcugraph/pyproject.toml
sed -i "s/cudf/cudf${CUDA_SUFFIX}/g" python/pylibcugraph/pyproject.toml

# cugraph pyproject.toml cuda suffixes
sed -i "s/name = \"cugraph\"/name = \"cugraph${CUDA_SUFFIX}\"/g" python/cugraph/pyproject.toml
sed -i "s/rmm/rmm${CUDA_SUFFIX}/g" python/cugraph/pyproject.toml
sed -i "s/cudf/cudf${CUDA_SUFFIX}/g" python/cugraph/pyproject.toml
sed -i "s/raft-dask/raft-dask${CUDA_SUFFIX}/g" python/cugraph/pyproject.toml
sed -i "s/pylibcugraph/pylibcugraph${CUDA_SUFFIX}/g" python/cugraph/pyproject.toml
sed -i "s/pylibraft/pylibraft${CUDA_SUFFIX}/g" python/cugraph/pyproject.toml
