#!/usr/bin/env bash
#
# Build the book as EPUB and PDF using pandoc inside Docker.
# Run from anywhere; paths are resolved relative to the repo root.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
IMAGE="howcryptoworks-pandoc:latest"
# The pandoc/latex base image ships amd64 only; force it so arm64 hosts emulate.
PLATFORM="linux/amd64"

# Chapters in reading order: preface first, then chapters 1 to 15.
CHAPTERS=(
  "Chapters/_preface.md"
  "Chapters/ch01_bitcoin.md"
  "Chapters/ch02_ethereum.md"
  "Chapters/ch03_solana.md"
  "Chapters/ch04_l1_blockchains.md"
  "Chapters/ch05_custody.md"
  "Chapters/ch06_market_structure.md"
  "Chapters/ch07_defi.md"
  "Chapters/ch08_mev.md"
  "Chapters/ch09_stablecoins_rwas.md"
  "Chapters/ch10_hyperliquid.md"
  "Chapters/ch11_nfts.md"
  "Chapters/ch12_governance.md"
  "Chapters/ch13_depin.md"
  "Chapters/ch14_quantum_resistance.md"
  "Chapters/ch15_prediction_markets.md"
)

META="build/metadata.yaml"
OUT_EPUB="build/how-crypto-actually-works.epub"
OUT_PDF="build/how-crypto-actually-works.pdf"

echo ">> Building Docker image ($IMAGE)..."
docker build --platform "$PLATFORM" -t "$IMAGE" "$SCRIPT_DIR"

# Common pandoc options. gfm input avoids treating "$" amounts as math.
COMMON_OPTS=(
  --from=gfm
  --metadata-file="$META"
  --toc
  --toc-depth=2
)

echo ">> Building EPUB..."
docker run --rm --platform "$PLATFORM" -v "$REPO_ROOT:/data" -w /data "$IMAGE" \
  "${COMMON_OPTS[@]}" \
  --split-level=1 \
  -o "$OUT_EPUB" \
  "${CHAPTERS[@]}"

echo ">> Building PDF (xelatex)..."
docker run --rm --platform "$PLATFORM" -v "$REPO_ROOT:/data" -w /data "$IMAGE" \
  "${COMMON_OPTS[@]}" \
  --pdf-engine=xelatex \
  --top-level-division=chapter \
  -o "$OUT_PDF" \
  "${CHAPTERS[@]}"

echo ">> Done:"
ls -lh "$REPO_ROOT/$OUT_EPUB" "$REPO_ROOT/$OUT_PDF"
