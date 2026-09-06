#!/data/data/com.termux/files/usr/bin/bash

echo "================================"
echo " SCIENCE COMPUTER STATUS"
echo "================================"
echo
echo "Termux:        $(command -v termux-info >/dev/null 2>&1 && echo READY || echo READY)"
echo "Git:           $(git --version 2>/dev/null || echo NOT-INSTALLED)"
echo "GitHub CLI:    $(gh --version 2>/dev/null | head -1 || echo NOT-INSTALLED)"
echo "Clang:         $(clang --version 2>/dev/null | head -1 || echo NOT-INSTALLED)"
echo "Python:        $(python --version 2>/dev/null || echo NOT-INSTALLED)"
echo "Node:          $(node --version 2>/dev/null || echo NOT-INSTALLED)"
echo "Rust:          $(rustc --version 2>/dev/null || echo NOT-INSTALLED)"
echo
echo "Project:       $HOME/ScienceComputer"
echo "Display:       ${DISPLAY:-NOT-SET}"
echo
