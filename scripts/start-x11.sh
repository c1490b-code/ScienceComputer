#!/data/data/com.termux/files/usr/bin/bash
set -e

export DISPLAY=:0

echo "=========================================="
echo " SCIENCE COMPUTER → TERMUX:X11"
echo "=========================================="

# Verify X11 is reachable
if ! command -v xdpyinfo >/dev/null 2>&1; then
    echo "Installing X11 utilities..."
    pkg install -y xorg-xdpyinfo
fi

if ! xdpyinfo >/dev/null 2>&1; then
    echo
    echo "Termux:X11 is not reachable."
    echo
    echo "Open the Termux:X11 app first."
    echo "Then run:"
    echo
    echo "  ~/ScienceComputer/scripts/start-x11.sh"
    exit 1
fi

echo "X11 display detected: $DISPLAY"
echo

# Start ScienceComputer
exec "$HOME/ScienceComputer/scripts/science-computer.sh"
