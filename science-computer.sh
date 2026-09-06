#!/data/data/com.termux/files/usr/bin/bash

ROOT="$HOME/ScienceComputer"

case "$1" in

  core)
    exec "$ROOT/core/core.sh"
    ;;

  engineering)
    exec "$ROOT/engineering/engineering.sh"
    ;;

  technical)
    exec "$ROOT/technical/technical.sh"
    ;;

  design)
    exec "$ROOT/design/design.sh"
    ;;

  simulation)
    exec "$ROOT/simulation/simulation.sh"
    ;;

  instrumentation)
    exec "$ROOT/instrumentation/instrumentation.sh"
    ;;

  development)
    exec "$ROOT/development/development.sh"
    ;;

  data)
    exec "$ROOT/data/data.sh"
    ;;

  ai)
    exec "$ROOT/ai/ai.sh"
    ;;

  network)
    exec "$ROOT/network/network.sh"
    ;;

  security)
    exec "$ROOT/security/security.sh"
    ;;

  files)
    exec "$ROOT/files/files.sh"
    ;;

  *)
    echo
    echo "SCIENCE COMPUTER"
    echo "================"
    echo
    echo "Technical Computer"
    echo
    echo "Commands:"
    echo
    echo "  core"
    echo "  engineering"
    echo "  technical"
    echo "  design"
    echo "  simulation"
    echo "  instrumentation"
    echo "  development"
    echo "  data"
    echo "  ai"
    echo "  network"
    echo "  security"
    echo "  files"
    echo
    ;;
esac
