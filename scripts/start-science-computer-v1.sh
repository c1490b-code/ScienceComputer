#!/data/data/com.termux/files/usr/bin/bash

export DISPLAY=:0

if ! xdpyinfo >/dev/null 2>&1; then
    echo "Termux:X11 is not available."
    echo "Open Termux:X11 first."
    exit 1
fi

exec "$HOME/ScienceComputer/desktop/bin/science-computer-v1"
