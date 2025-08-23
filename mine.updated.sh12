#!/bin/bash
set -e

# =====================================
# Konfigurasi via ENV (Modal injects these)
# =====================================
WALLET="${WALLET:?WALLET not set}"
WORKER="${WORKER:-modalworker}"
THREADS="${THREADS:-$(nproc)}"
POOL_SERVER="${POOL_SERVER:-eu.catchthatrabbit.com}"
POOL_PORT="${POOL_PORT:-8008}"

# =====================================
# Opsi optimasi CPU
# =====================================
SECURE_JIT=""
cOS=$(uname -s)
cPLT=$(uname -m)
if [ "$cOS" == "Darwin" ] && [ "$cPLT" == "arm64" ]; then
  SECURE_JIT="--jit-secure"
fi

LARGE_PAGES=""
if [ -f /proc/sys/vm/nr_hugepages ] && [ $(cat /proc/sys/vm/nr_hugepages) -gt 0 ]; then
  LARGE_PAGES="--large-pages"
fi

HARD_AES=""
if grep -q aes /proc/cpuinfo 2>/dev/null; then
  HARD_AES="--hard-aes"
fi

# =====================================
# Compose stratum
# =====================================
STRATUM="stratum1+tcp://${WALLET}.${WORKER}@${POOL_SERVER}:${POOL_PORT}"

echo "====================================="
echo "🚀 Starting CoreMiner (Modal Sandbox)"
echo " Wallet : $WALLET"
echo " Worker : $WORKER"
echo " Server : $POOL_SERVER:$POOL_PORT"
echo " Threads: $THREADS"
echo "====================================="

# =====================================
# Start mining
# =====================================
if [ ! -x "./coreminer" ]; then
  echo "❌ coreminer binary not found or not executable!"
  exit 1
fi

exec ./coreminer --noeval $LARGE_PAGES $HARD_AES $SECURE_JIT -P "$STRATUM" -t "$THREADS"
