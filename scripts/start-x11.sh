#!/data/data/com.termux/files/usr/bin/bash

export DISPLAY=:0

echo "=========================================="
echo " SCIENCE COMPUTER → TERMUX:X11"
echo "=========================================="
echo "DISPLAY=$DISPLAY"

if ! xdpyinfo >/dev/null 2>&1; then
    echo "Termux:X11 is not reachable."
    echo "Open Termux:X11 and run this again."
    exit 1
fi

exec "$HOME/ScienceComputer/scripts/science-computer.sh"
