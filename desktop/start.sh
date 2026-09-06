#!/data/data/com.termux/files/usr/bin/bash

ROOT="$HOME/ScienceComputer"

if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

echo "Starting ScienceComputer Desktop..."
echo "DISPLAY=$DISPLAY"

exec "$ROOT/desktop/bin/science-desktop"
