#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/ScienceComputer"
cd "$ROOT"

echo "=========================================="
echo " SCIENCE COMPUTER — FULL CORE BUILD"
echo "=========================================="

mkdir -p \
core \
engineering \
technical \
applications \
development \
data \
ai \
design \
simulation \
instrumentation \
network \
security \
files \
tools \
config \
docs \
tests \
scripts

# --------------------------------------------------
# MASTER COMPUTER DEFINITION
# --------------------------------------------------

cat > computer.json <<'JSON'
{
  "name": "ScienceComputer",
  "version": "0.1.0",
  "type": "Technical Computer",
  "runtime": "Termux",
  "display": "Termux:X11",
  "architecture": {
    "core": true,
    "engineering": true,
    "technical_science": true,
    "technical_applications": true,
    "applications": true,
    "development": true,
    "data": true,
    "ai": true,
    "design": true,
    "simulation": true,
    "instrumentation": true,
    "network": true,
    "security": true,
    "files": true
  }
}
JSON

# --------------------------------------------------
# CORE
# --------------------------------------------------

cat > core/core.sh <<'CORE'
#!/data/data/com.termux/files/usr/bin/bash

echo "SCIENCE COMPUTER CORE"
echo "====================="
echo "Runtime: Termux"
echo "Architecture: Technical Computer"
echo
CORE

chmod +x core/core.sh

# --------------------------------------------------
# ENGINEERING
# --------------------------------------------------

cat > engineering/engineering.sh <<'ENG'
#!/data/data/com.termux/files/usr/bin/bash

echo "ENGINEERING"
echo "==========="
echo
echo "Systems"
echo "Electrical"
echo "Electronics"
echo "Mechanical"
echo "Robotics"
echo "Aerospace"
echo "Civil"
echo "Manufacturing"
echo
ENG

chmod +x engineering/engineering.sh

# --------------------------------------------------
# TECHNICAL SCIENCE
# --------------------------------------------------

cat > technical/technical.sh <<'TECH'
#!/data/data/com.termux/files/usr/bin/bash

echo "TECHNICAL SCIENCE"
echo "================="
echo
echo "Computer Science"
echo "Mathematics"
echo "Physics"
echo "Chemistry"
echo "Materials"
echo "Biology"
echo "Earth Science"
echo "Space Science"
echo
TECH

chmod +x technical/technical.sh

# --------------------------------------------------
# DESIGN
# --------------------------------------------------

cat > design/design.sh <<'DESIGN'
#!/data/data/com.termux/files/usr/bin/bash

echo "TECHNICAL DESIGN"
echo "================"
echo
echo "CAD"
echo "Technical Drawing"
echo "3D Modeling"
echo "Visualization"
echo "Technical Art"
echo
DESIGN

chmod +x design/design.sh

# --------------------------------------------------
# SIMULATION
# --------------------------------------------------

cat > simulation/simulation.sh <<'SIM'
#!/data/data/com.termux/files/usr/bin/bash

echo "SIMULATION"
echo "=========="
echo
echo "Physics"
echo "Engineering"
echo "Robotics"
echo "Systems"
echo "Modeling"
echo "Digital Twins"
echo
SIM

chmod +x simulation/simulation.sh

# --------------------------------------------------
# INSTRUMENTATION
# --------------------------------------------------

cat > instrumentation/instrumentation.sh <<'INST'
#!/data/data/com.termux/files/usr/bin/bash

echo "INSTRUMENTATION"
echo "==============="
echo
echo "Sensors"
echo "Measurement"
echo "Imaging"
echo "Data Acquisition"
echo "Laboratory Interfaces"
echo
INST

chmod +x instrumentation/instrumentation.sh

# --------------------------------------------------
# DEVELOPMENT
# --------------------------------------------------

cat > development/development.sh <<'DEV'
#!/data/data/com.termux/files/usr/bin/bash

echo "DEVELOPMENT"
echo "==========="
echo
echo "C/C++"
echo "Python"
echo "Rust"
echo "Node.js"
echo "Compiler"
echo "Build System"
echo "Debugger"
echo "Git"
echo "GitHub"
echo "APIs"
echo
DEV

chmod +x development/development.sh

# --------------------------------------------------
# DATA
# --------------------------------------------------

cat > data/data.sh <<'DATA'
#!/data/data/com.termux/files/usr/bin/bash

echo "DATA"
echo "===="
echo
echo "Storage"
echo "Databases"
echo "Scientific Data"
echo "Engineering Data"
echo "Analysis"
echo "Visualization"
echo
DATA

chmod +x data/data.sh

# --------------------------------------------------
# AI
# --------------------------------------------------

cat > ai/ai.sh <<'AI'
#!/data/data/com.termux/files/usr/bin/bash

echo "AI"
echo "=="
echo
echo "Machine Learning"
echo "Inference"
echo "Automation"
echo "Data Processing"
echo "Model Development"
echo
AI

chmod +x ai/ai.sh

# --------------------------------------------------
# NETWORK
# --------------------------------------------------

cat > network/network.sh <<'NET'
#!/data/data/com.termux/files/usr/bin/bash

echo "NETWORK"
echo "======="
echo
echo "Network interfaces:"
ip addr 2>/dev/null || true
echo
echo "Routes:"
ip route 2>/dev/null || true
NET

chmod +x network/network.sh

# --------------------------------------------------
# SECURITY
# --------------------------------------------------

cat > security/security.sh <<'SEC'
#!/data/data/com.termux/files/usr/bin/bash

echo "SECURITY"
echo "========"
echo
echo "System security"
echo "Application security"
echo "Network security"
echo "Credential management"
echo "Development security"
echo
SEC

chmod +x security/security.sh

# --------------------------------------------------
# FILES
# --------------------------------------------------

cat > files/files.sh <<'FILES'
#!/data/data/com.termux/files/usr/bin/bash

echo "SCIENCE COMPUTER FILE SYSTEM"
echo "============================"
echo
echo "Home: $HOME"
echo
ls -la "$HOME"
FILES

chmod +x files/files.sh

# --------------------------------------------------
# APPLICATION REGISTRY
# --------------------------------------------------

cat > applications/registry.json <<'JSON'
{
  "engineering": [],
  "technical": [],
  "science": [],
  "design": [],
  "simulation": [],
  "instrumentation": [],
  "development": [],
  "data": [],
  "ai": [],
  "general": []
}
JSON

# --------------------------------------------------
# MASTER COMMAND
# --------------------------------------------------

cat > science-computer.sh <<'MASTER'
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
MASTER

chmod +x science-computer.sh

# --------------------------------------------------
# TERMUX COMMAND
# --------------------------------------------------

mkdir -p "$HOME/bin"

ln -sf "$ROOT/science-computer.sh" "$HOME/bin/science-computer"

# --------------------------------------------------
# SYSTEM DESCRIPTION
# --------------------------------------------------

cat > docs/COMPUTER.md <<'DOC'
# ScienceComputer

ScienceComputer is a technical computer environment.

The computer is organized around:

- Computing
- Engineering
- Technical Science
- Design
- Simulation
- Instrumentation
- Development
- Data
- AI
- Networking
- Security
- Files
- Applications

The foundation is Termux.

Termux:X11 is the future graphical display layer.

The graphical desktop is intentionally built AFTER the computer core
and technical applications.
DOC

# --------------------------------------------------
# TEST
# --------------------------------------------------

echo
echo "Running core test..."
./science-computer.sh core

echo
echo "Running engineering test..."
./science-computer.sh engineering

echo
echo "Running technical test..."
./science-computer.sh technical

# --------------------------------------------------
# GITHUB
# --------------------------------------------------

git add .

git commit -m "Build complete ScienceComputer technical core" || true

git push origin main

echo
echo "=========================================="
echo " SCIENCE COMPUTER CORE COMPLETE"
echo "=========================================="
echo
echo "GitHub:"
git remote get-url origin
echo
echo "Try:"
echo
echo "  science-computer"
echo "  science-computer engineering"
echo "  science-computer technical"
echo "  science-computer development"
echo "  science-computer design"
echo "  science-computer simulation"
echo "  science-computer ai"
echo "  science-computer data"
echo "  science-computer files"
echo
echo "The desktop comes AFTER the computer."
