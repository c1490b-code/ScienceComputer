#!/data/data/com.termux/files/usr/bin/bash

if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

echo "ScienceComputer X11 test"
echo "DISPLAY=$DISPLAY"

if "$HOME/ScienceComputer/desktop/bin/science-desktop"; then
    echo "Desktop exited normally."
else
    echo "Desktop could not start."
    exit 1
fi
