#!/data/data/com.termux/files/usr/bin/bash

export DISPLAY=:0

echo "Starting ScienceComputer Desktop..."
echo "DISPLAY=$DISPLAY"

if ! "$HOME/ScienceComputer/desktop/bin/science-desktop"; then
    echo
    echo "ScienceComputer could not connect to Termux:X11."
    echo
    echo "Make sure the Termux:X11 application is open."
    echo "Then run:"
    echo
    echo "export DISPLAY=:0"
    echo "$HOME/ScienceComputer/scripts/start-desktop.sh"
    exit 1
fi
