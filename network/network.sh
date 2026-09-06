#!/data/data/com.termux/files/usr/bin/bash

echo "NETWORK"
echo "======="
echo
echo "Network interfaces:"
ip addr 2>/dev/null || true
echo
echo "Routes:"
ip route 2>/dev/null || true
