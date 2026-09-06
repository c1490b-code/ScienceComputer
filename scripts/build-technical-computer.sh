#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/ScienceComputer"
cd "$ROOT"

echo "=== SCIENCE COMPUTER ==="
echo "=== TECHNICAL COMPUTER BUILD ==="

mkdir -p \
  core/{runtime,system,hardware,networking,storage,security} \
  engineering/{systems,electrical,electronics,mechanical,robotics,aerospace,manufacturing,civil} \
  technical/{computing,mathematics,physics,chemistry,materials,biology,earth,space} \
  applications/{engineering,technical,development,science,design,simulation,data,instruments} \
  applications/general \
  desktop/{shell,workspace,launcher,windows,panels} \
  development/{compiler,build,debug,git,github,api} \
  tools \
  scripts \
  tests \
  docs

# ------------------------------------------------------------
# MASTER ARCHITECTURE
# ------------------------------------------------------------

cat > ARCHITECTURE.md <<'DOC'
# ScienceComputer

## Technical Computer Architecture

ScienceComputer is a technical computing environment built directly
on the Termux runtime and displayed through Termux:X11.

The architecture is:

Android
  -> Termux
    -> ScienceComputer Core
      -> Engineering
      -> Technical Science
      -> Technical Applications
      -> General Applications
      -> Development
      -> ScienceComputer Desktop
        -> Termux:X11

## Priority

1. Core computer/runtime
2. Engineering
3. Technical applications
4. Applications
5. Desktop experience

The computer is designed around technical computation, engineering,
scientific computing, design, simulation, instrumentation, data,
programming and application development.
DOC

# ------------------------------------------------------------
# ENGINEERING REGISTRY
# ------------------------------------------------------------

cat > engineering/engineering.json <<'JSON'
{
  "name": "Engineering",
  "status": "active",
  "disciplines": [
    "systems",
    "electrical",
    "electronics",
    "mechanical",
    "robotics",
    "aerospace",
    "manufacturing",
    "civil"
  ],
  "capabilities": [
    "modeling",
    "calculation",
    "simulation",
    "design",
    "automation",
    "measurement",
    "data_analysis",
    "technical_documentation"
  ]
}
JSON

# ------------------------------------------------------------
# TECHNICAL FIELD REGISTRY
# ------------------------------------------------------------

cat > technical/technical.json <<'JSON'
{
  "name": "Technical",
  "fields": {
    "computing": [
      "computer_science",
      "software_engineering",
      "algorithms",
      "operating_systems",
      "networks",
      "databases",
      "artificial_intelligence",
      "cybersecurity"
    ],
    "science": [
      "mathematics",
      "physics",
      "chemistry",
      "materials",
      "biology",
      "earth_science",
      "space_science"
    ],
    "design": [
      "cad",
      "technical_drawing",
      "3d_modeling",
      "visualization",
      "technical_art"
    ],
    "simulation": [
      "physics",
      "engineering",
      "robotics",
      "systems",
      "digital_twins"
    ],
    "instrumentation": [
      "sensors",
      "measurement",
      "imaging",
      "data_acquisition",
      "laboratory_systems"
    ]
  }
}
JSON

# ------------------------------------------------------------
# APPLICATION REGISTRY
# ------------------------------------------------------------

cat > applications/applications.json <<'JSON'
{
  "technical_applications": [
    "engineering_workbench",
    "technical_calculator",
    "cad",
    "3d_modeler",
    "simulation",
    "scientific_computing",
    "data_analysis",
    "instrumentation",
    "electronics",
    "robotics",
    "technical_editor",
    "code_editor"
  ],
  "applications": [
    "file_manager",
    "terminal",
    "browser",
    "media",
    "documents",
    "settings"
  ]
}
JSON

# ------------------------------------------------------------
# ENGINEERING WORKBENCH
# ------------------------------------------------------------

cat > applications/engineering/engineering_workbench.py <<'PY'
#!/usr/bin/env python3

import math

print()
print("SCIENCE COMPUTER")
print("ENGINEERING WORKBENCH")
print("==============================")
print()
print("Engineering computation environment")
print()
print("Available:")
print("  1. Force")
print("  2. Power")
print("  3. Ohm's Law")
print("  4. Area")
print("  5. Volume")
print("  6. Exit")
print()

while True:
    choice = input("ENGINEERING> ").strip()

    if choice == "1":
        mass = float(input("Mass (kg): "))
        acceleration = float(input("Acceleration (m/s²): "))
        print("Force =", mass * acceleration, "N")

    elif choice == "2":
        voltage = float(input("Voltage (V): "))
        current = float(input("Current (A): "))
        print("Power =", voltage * current, "W")

    elif choice == "3":
        voltage = float(input("Voltage (V): "))
        resistance = float(input("Resistance (Ω): "))
        print("Current =", voltage / resistance, "A")

    elif choice == "4":
        width = float(input("Width: "))
        length = float(input("Length: "))
        print("Area =", width * length)

    elif choice == "5":
        width = float(input("Width: "))
        length = float(input("Length: "))
        height = float(input("Height: "))
        print("Volume =", width * length * height)

    elif choice == "6":
        break

    else:
        print("Unknown engineering operation.")
PY

chmod +x applications/engineering/engineering_workbench.py

# ------------------------------------------------------------
# TECHNICAL APPLICATION LAUNCHER
# ------------------------------------------------------------

cat > applications/technical-launcher.py <<'PY'
#!/usr/bin/env python3

import os
import subprocess

ROOT = os.path.expanduser("~/ScienceComputer")

apps = {
    "1": ("Engineering Workbench",
          f"{ROOT}/applications/engineering/engineering_workbench.py"),
}

print()
print("SCIENCE COMPUTER")
print("TECHNICAL APPLICATIONS")
print("==============================")

for number, (name, _) in apps.items():
    print(f"{number}. {name}")

print("0. Exit")

while True:
    choice = input("\nTECHNICAL> ").strip()

    if choice == "0":
        break

    if choice in apps:
        subprocess.run(["python", apps[choice][1]])
    else:
        print("Unknown application.")
PY

chmod +x applications/technical-launcher.py

# ------------------------------------------------------------
# MAIN COMPUTER COMMAND
# ------------------------------------------------------------

cat > scripts/science-computer.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash

ROOT="$HOME/ScienceComputer"

echo
echo "=========================================="
echo "          SCIENCE COMPUTER"
echo "=========================================="
echo
echo "TECHNICAL COMPUTER"
echo
echo "  ENGINEERING"
echo "  TECHNICAL"
echo "  TECHNICAL APPLICATIONS"
echo "  APPLICATIONS"
echo "  DEVELOPMENT"
echo "  FILES"
echo "  TERMINAL"
echo "  GITHUB"
echo

echo "Core:"
echo "  $ROOT/core"

echo
echo "Engineering:"
echo "  $ROOT/engineering"

echo
echo "Technical applications:"
echo "  $ROOT/applications"

echo
echo "Desktop:"
echo "  $ROOT/desktop"

echo
echo "Runtime: Termux"
echo "Graphics: Termux:X11"
echo
SH

chmod +x scripts/science-computer.sh

# ------------------------------------------------------------
# ENGINEERING BUILD COMMAND
# ------------------------------------------------------------

cat > scripts/engineering.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME/ScienceComputer"
exec python applications/engineering/engineering_workbench.py
SH

chmod +x scripts/engineering.sh

# ------------------------------------------------------------
# TECHNICAL APPLICATION COMMAND
# ------------------------------------------------------------

cat > scripts/technical-apps.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME/ScienceComputer"
exec python applications/technical-launcher.py
SH

chmod +x scripts/technical-apps.sh

# ------------------------------------------------------------
# GLOBAL TERMUX COMMANDS
# ------------------------------------------------------------

mkdir -p "$HOME/bin"

ln -sf "$ROOT/scripts/science-computer.sh" "$HOME/bin/science-computer"
ln -sf "$ROOT/scripts/engineering.sh" "$HOME/bin/engineering"
ln -sf "$ROOT/scripts/technical-apps.sh" "$HOME/bin/technical-apps"

# ------------------------------------------------------------
# BUILD INDEX
# ------------------------------------------------------------

cat > BUILD.md <<'DOC'
# ScienceComputer Build

## Build order

### 01 — Core
Runtime, filesystem, hardware, networking, storage and security.

### 02 — Engineering
Engineering disciplines and computational workbenches.

### 03 — Technical
Computing, mathematics, physics, chemistry, materials, biology,
space, design, simulation and instrumentation.

### 04 — Technical Applications
Applications built specifically for technical work.

### 05 — Applications
General computer applications.

### 06 — Desktop
The graphical ScienceComputer environment through Termux:X11.

### 07 — Development
Compiler, debugger, Git, GitHub, APIs and build infrastructure.
DOC

# ------------------------------------------------------------
# GIT + GITHUB
# ------------------------------------------------------------

git add .

git commit -m "Build technical computer architecture and engineering layer" || true

git push origin main

echo
echo "=========================================="
echo " TECHNICAL COMPUTER ONLINE"
echo "=========================================="
echo
echo "GitHub:"
git remote get-url origin
echo
echo "Run:"
echo "  science-computer"
echo
echo "Engineering:"
echo "  engineering"
echo
echo "Technical applications:"
echo "  technical-apps"
echo
SH

chmod +x scripts/build-technical-computer.sh

./scripts/build-technical-computer.sh
engineering
technical-apps
git status
git log --oneline -3
exit

exit

