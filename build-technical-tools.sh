#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/ScienceComputer"
mkdir -p "$ROOT"/modules "$ROOT"/workspace/{projects,data,models,designs,simulations,instruments}
mkdir -p "$HOME/bin"

echo "=========================================="
echo " SCIENCE COMPUTER — TECHNICAL TOOLS"
echo "=========================================="

# --------------------------------------------------
# PYTHON TECHNICAL ENGINE
# --------------------------------------------------

cat > "$ROOT/modules/technical.py" <<'PY'
#!/usr/bin/env python3

import sys
import math
import json
import csv
import os
import ast
import operator
import statistics

ROOT = os.path.expanduser("~/ScienceComputer")

# ---------- SAFE MATH ----------

OPS = {
    ast.Add: operator.add,
    ast.Sub: operator.sub,
    ast.Mult: operator.mul,
    ast.Div: operator.truediv,
    ast.Pow: operator.pow,
    ast.Mod: operator.mod,
    ast.USub: operator.neg,
    ast.UAdd: operator.pos,
}

FUNCS = {
    "sqrt": math.sqrt,
    "sin": math.sin,
    "cos": math.cos,
    "tan": math.tan,
    "asin": math.asin,
    "acos": math.acos,
    "atan": math.atan,
    "log": math.log,
    "log10": math.log10,
    "exp": math.exp,
    "abs": abs,
    "floor": math.floor,
    "ceil": math.ceil,
}

CONSTANTS = {
    "pi": math.pi,
    "e": math.e,
    "c": 299792458,
    "g": 9.80665,
}

def safe_eval(expr):
    tree = ast.parse(expr, mode="eval")

    def calc(node):
        if isinstance(node, ast.Constant):
            if isinstance(node.value, (int, float)):
                return node.value
            raise ValueError("Invalid constant")

        if isinstance(node, ast.Name):
            if node.id in CONSTANTS:
                return CONSTANTS[node.id]
            if node.id in FUNCS:
                return FUNCS[node.id]
            raise ValueError("Unknown name")

        if isinstance(node, ast.BinOp):
            return OPS[type(node.op)](calc(node.left), calc(node.right))

        if isinstance(node, ast.UnaryOp):
            return OPS[type(node.op)](calc(node.operand))

        if isinstance(node, ast.Call):
            fn = calc(node.func)
            return fn(*[calc(a) for a in node.args])

        raise ValueError("Expression not allowed")

    return calc(tree.body)


# ---------- ENGINEERING ----------

def engineering():
    print("""
ENGINEERING CALCULATOR
======================

1  Force       F = m*a
2  Power       P = V*I
3  Ohm         V = I*R
4  Kinetic     E = 0.5*m*v^2
5  Potential   E = m*g*h
6  Stress      stress = force/area
7  Density     density = mass/volume
""")

    x = input("Select: ").strip()

    try:
        if x == "1":
            m = float(input("Mass kg: "))
            a = float(input("Acceleration m/s²: "))
            print("Force:", m*a, "N")

        elif x == "2":
            v = float(input("Voltage V: "))
            i = float(input("Current A: "))
            print("Power:", v*i, "W")

        elif x == "3":
            i = float(input("Current A: "))
            r = float(input("Resistance Ω: "))
            print("Voltage:", i*r, "V")

        elif x == "4":
            m = float(input("Mass kg: "))
            v = float(input("Velocity m/s: "))
            print("Kinetic energy:", 0.5*m*v*v, "J")

        elif x == "5":
            m = float(input("Mass kg: "))
            h = float(input("Height m: "))
            print("Potential energy:", m*CONSTANTS["g"]*h, "J")

        elif x == "6":
            f = float(input("Force N: "))
            a = float(input("Area m²: "))
            print("Stress:", f/a, "Pa")

        elif x == "7":
            m = float(input("Mass kg: "))
            v = float(input("Volume m³: "))
            print("Density:", m/v, "kg/m³")

    except Exception as e:
        print("Error:", e)


# ---------- ELECTRONICS ----------

def electronics():
    print("""
ELECTRONICS
===========

1 Ohm's Law
2 Series Resistance
3 Parallel Resistance
4 Electrical Power
""")

    x = input("Select: ").strip()

    try:
        if x == "1":
            r = float(input("Resistance Ω: "))
            i = float(input("Current A: "))
            print("Voltage:", r*i, "V")

        elif x == "2":
            values = input("Resistors Ω separated by spaces: ")
            values = [float(v) for v in values.split()]
            print("Series:", sum(values), "Ω")

        elif x == "3":
            values = input("Resistors Ω separated by spaces: ")
            values = [float(v) for v in values.split()]
            result = 1 / sum(1/v for v in values)
            print("Parallel:", result, "Ω")

        elif x == "4":
            v = float(input("Voltage V: "))
            i = float(input("Current A: "))
            print("Power:", v*i, "W")

    except Exception as e:
        print("Error:", e)


# ---------- PHYSICS ----------

def physics():
    print("""
PHYSICS
=======

1 Velocity       v = d/t
2 Acceleration   a = Δv/t
3 Force          F = ma
4 Momentum       p = mv
5 Kinetic Energy
6 Wave           v = fλ
""")

    x = input("Select: ").strip()

    try:
        if x == "1":
            d = float(input("Distance m: "))
            t = float(input("Time s: "))
            print("Velocity:", d/t, "m/s")

        elif x == "2":
            dv = float(input("Change in velocity m/s: "))
            t = float(input("Time s: "))
            print("Acceleration:", dv/t, "m/s²")

        elif x == "3":
            m = float(input("Mass kg: "))
            a = float(input("Acceleration m/s²: "))
            print("Force:", m*a, "N")

        elif x == "4":
            m = float(input("Mass kg: "))
            v = float(input("Velocity m/s: "))
            print("Momentum:", m*v, "kg·m/s")

        elif x == "5":
            m = float(input("Mass kg: "))
            v = float(input("Velocity m/s: "))
            print("Energy:", 0.5*m*v*v, "J")

        elif x == "6":
            f = float(input("Frequency Hz: "))
            wavelength = float(input("Wavelength m: "))
            print("Wave velocity:", f*wavelength, "m/s")

    except Exception as e:
        print("Error:", e)


# ---------- MATHEMATICS ----------

def mathematics():
    print("""
MATHEMATICS
===========

Enter a mathematical expression.

Examples:
  2+2
  sqrt(144)
  sin(pi/2)
  25*4
  2**10

Constants:
  pi
  e
  c
  g

Type exit to quit.
""")

    while True:
        expr = input("math> ").strip()

        if expr.lower() in ("exit", "quit"):
            break

        try:
            print(safe_eval(expr))
        except Exception as e:
            print("Error:", e)


# ---------- DATA ----------

def data_tool():
    print("""
DATA TOOL
=========

1 Inspect JSON
2 Inspect CSV
3 Statistics
""")

    x = input("Select: ").strip()

    if x == "1":
        path = os.path.expanduser(input("JSON file: "))
        with open(path) as f:
            obj = json.load(f)
        print(json.dumps(obj, indent=2)[:10000])

    elif x == "2":
        path = os.path.expanduser(input("CSV file: "))
        with open(path, newline="") as f:
            rows = list(csv.reader(f))
        for row in rows[:20]:
            print(row)

        print("Rows:", len(rows))

    elif x == "3":
        values = input("Numbers: ")
        values = [float(v) for v in values.split()]
        print("Count:", len(values))
        print("Mean:", statistics.mean(values))
        print("Min:", min(values))
        print("Max:", max(values))


# ---------- SIMULATION ----------

def simulation():
    print("""
SIMULATION
==========

Simple projectile simulation.

""")

    try:
        velocity = float(input("Initial velocity m/s: "))
        angle = float(input("Angle degrees: "))

        theta = math.radians(angle)
        vx = velocity * math.cos(theta)
        vy = velocity * math.sin(theta)

        t = 0
        dt = 0.1
        y = 0

        while t <= 100:
            y = vy*t - 0.5*CONSTANTS["g"]*t*t

            if y < 0:
                break

            x = vx*t
            print(f"t={t:6.2f}s  x={x:10.3f}m  y={y:10.3f}m")
            t += dt

    except Exception as e:
        print("Error:", e)


# ---------- ROBOTICS ----------

def robotics():
    print("""
ROBOTICS
========

1 2D position
2 Distance between points
3 Differential-drive estimate
""")

    x = input("Select: ").strip()

    try:
        if x == "1":
            px = float(input("X: "))
            py = float(input("Y: "))
            print("Position:", px, py)

        elif x == "2":
            x1 = float(input("X1: "))
            y1 = float(input("Y1: "))
            x2 = float(input("X2: "))
            y2 = float(input("Y2: "))
            d = math.sqrt((x2-x1)**2 + (y2-y1)**2)
            print("Distance:", d)

        elif x == "3":
            left = float(input("Left wheel velocity: "))
            right = float(input("Right wheel velocity: "))
            width = float(input("Wheel separation: "))

            linear = (right+left)/2
            angular = (right-left)/width

            print("Linear velocity:", linear)
            print("Angular velocity:", angular)

    except Exception as e:
        print("Error:", e)


# ---------- PROJECT CREATOR ----------

def project():
    name = input("Project name: ").strip()

    if not name:
        return

    safe = "".join(c for c in name if c.isalnum() or c in "_-")

    path = os.path.join(ROOT, "workspace", "projects", safe)

    os.makedirs(path, exist_ok=True)

    with open(os.path.join(path, "project.json"), "w") as f:
        json.dump({
            "name": name,
            "type": "ScienceComputer Technical Project",
            "status": "created"
        }, f, indent=2)

    with open(os.path.join(path, "README.md"), "w") as f:
        f.write(f"# {name}\n\nScienceComputer technical project.\n")

    print("Created:", path)


# ---------- SYSTEM ----------

def system():
    print("""
SCIENCE COMPUTER SYSTEM
=======================

Root:
""", ROOT)

    print("\nWorkspace:")
    print(os.path.join(ROOT, "workspace"))

    print("\nPython:", sys.version.split()[0])

    for command in ["clang", "clang++", "git", "python", "node", "rustc"]:
        found = os.system(f"command -v {command} >/dev/null 2>&1")
        print(f"{command:8}:", "available" if found == 0 else "not installed")


# ---------- MAIN ----------

COMMANDS = {
    "engineering": engineering,
    "electronics": electronics,
    "physics": physics,
    "math": mathematics,
    "mathematics": mathematics,
    "data": data_tool,
    "simulation": simulation,
    "robotics": robotics,
    "project": project,
    "system": system,
}

def main():
    if len(sys.argv) < 2:
        print("""
SCIENCE COMPUTER TECHNICAL ENGINE

Commands:

  sc engineering
  sc electronics
  sc physics
  sc math
  sc data
  sc simulation
  sc robotics
  sc project
  sc system
""")
        return

    command = sys.argv[1].lower()

    if command in COMMANDS:
        COMMANDS[command]()
    else:
        print("Unknown technical command:", command)

if __name__ == "__main__":
    main()
PY

chmod +x "$ROOT/modules/technical.py"

# --------------------------------------------------
# MASTER SC COMMAND
# --------------------------------------------------

cat > "$HOME/bin/sc" <<'SC'
#!/data/data/com.termux/files/usr/bin/bash

ROOT="$HOME/ScienceComputer"

case "$1" in
  engineering|electronics|physics|math|mathematics|data|simulation|robotics|project|system)
    exec python "$ROOT/modules/technical.py" "$@"
    ;;

  computer)
    exec "$ROOT/science-computer.sh"
    ;;

  status)
    echo "SCIENCE COMPUTER"
    echo "================"
    echo
    cat "$ROOT/computer.json"
    ;;

  workspace)
    cd "$ROOT/workspace"
    exec "$SHELL"
    ;;

  help|*)
    echo
    echo "SCIENCE COMPUTER"
    echo "================"
    echo
    echo "Technical commands:"
    echo
    echo "  sc engineering"
    echo "  sc electronics"
    echo "  sc physics"
    echo "  sc math"
    echo "  sc data"
    echo "  sc simulation"
    echo "  sc robotics"
    echo "  sc project"
    echo "  sc system"
    echo
    echo "Computer:"
    echo
    echo "  sc computer"
    echo "  sc status"
    echo "  sc workspace"
    echo
    ;;
esac
SC

chmod +x "$HOME/bin/sc"

# --------------------------------------------------
# SPECIAL DIRECT COMMANDS
# --------------------------------------------------

for cmd in engineering electronics physics math simulation robotics sc-system; do
    case "$cmd" in
        engineering)
            cat > "$HOME/bin/engineering" <<'EOF2'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/bin/sc" engineering "$@"
EOF2
            ;;
        electronics)
            cat > "$HOME/bin/electronics" <<'EOF2'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/bin/sc" electronics "$@"
EOF2
            ;;
        physics)
            cat > "$HOME/bin/physics" <<'EOF2'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/bin/sc" physics "$@"
EOF2
            ;;
        math)
            cat > "$HOME/bin/math" <<'EOF2'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/bin/sc" math "$@"
EOF2
            ;;
        simulation)
            cat > "$HOME/bin/simulation" <<'EOF2'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/bin/sc" simulation "$@"
EOF2
            ;;
        robotics)
            cat > "$HOME/bin/robotics" <<'EOF2'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/bin/sc" robotics "$@"
EOF2
            ;;
        sc-system)
            cat > "$HOME/bin/sc-system" <<'EOF2'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/bin/sc" system "$@"
EOF2
            ;;
    esac

    chmod +x "$HOME/bin/$cmd"
done

# --------------------------------------------------
# PACKAGE CHECK
# --------------------------------------------------

echo
echo "Checking native Termux development tools..."

for pkg in clang python git; do
    if command -v "$pkg" >/dev/null 2>&1; then
        echo "OK: $pkg"
    else
        echo "Installing: $pkg"
        pkg install -y "$pkg"
    fi
done

# --------------------------------------------------
# TEST
# --------------------------------------------------

echo
echo "Testing ScienceComputer..."

"$HOME/bin/sc" system

echo
echo "Testing mathematics..."

python "$ROOT/modules/technical.py" <<'INPUT'
INPUT

# --------------------------------------------------
# GITHUB SYNC
# --------------------------------------------------

cd "$ROOT"

git add .

git commit -m "Add working ScienceComputer technical tools" || true

git push origin main

echo
echo "=========================================="
echo " TECHNICAL COMPUTER BUILD COMPLETE"
echo "=========================================="
echo
echo "Available:"
echo
echo "  sc"
echo "  sc engineering"
echo "  sc electronics"
echo "  sc physics"
echo "  sc math"
echo "  sc data"
echo "  sc simulation"
echo "  sc robotics"
echo "  sc project"
echo "  sc system"
echo
echo "Direct commands:"
echo
echo "  engineering"
echo "  electronics"
echo "  physics"
echo "  math"
echo "  simulation"
echo "  robotics"
echo
echo "Workspace:"
echo "  ~/ScienceComputer/workspace"
echo
echo "GitHub synchronized."
