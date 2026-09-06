#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/ScienceComputer"

mkdir -p \
  "$ROOT/market" \
  "$ROOT/market/catalog" \
  "$ROOT/market/inventory" \
  "$ROOT/market/suppliers" \
  "$ROOT/market/orders" \
  "$ROOT/market/delivery" \
  "$ROOT/market/projects" \
  "$ROOT/market/data"

# ==================================================
# TECHNICAL MARKET DEFINITION
# ==================================================

cat > "$ROOT/market/market.json" <<'JSON'
{
  "name": "ScienceComputer Technical Market",
  "version": "0.1.0",
  "purpose": "Technical personal store and delivery platform",
  "categories": [
    "computers",
    "electronics",
    "components",
    "sensors",
    "robotics",
    "engineering",
    "tools",
    "instrumentation",
    "laboratory",
    "fabrication",
    "3d_printing",
    "materials",
    "power",
    "networking",
    "software",
    "development",
    "project_kits",
    "replacement_parts"
  ],
  "services": [
    "technical_procurement",
    "project_bom",
    "inventory",
    "delivery",
    "technical_support"
  ]
}
JSON

# ==================================================
# PRODUCT CATALOG
# ==================================================

cat > "$ROOT/market/catalog/products.json" <<'JSON'
{
  "products": [
    {
      "id": "SC-COMPUTER-001",
      "category": "computers",
      "name": "ScienceComputer Technical Workstation",
      "type": "computer",
      "status": "planned"
    },
    {
      "id": "SC-ELEC-001",
      "category": "electronics",
      "name": "Technical Electronics Starter Kit",
      "type": "project_kit",
      "status": "planned"
    },
    {
      "id": "SC-SENSOR-001",
      "category": "sensors",
      "name": "Technical Sensor Kit",
      "type": "project_kit",
      "status": "planned"
    },
    {
      "id": "SC-ROBOT-001",
      "category": "robotics",
      "name": "Robotics Development Kit",
      "type": "project_kit",
      "status": "planned"
    },
    {
      "id": "SC-INST-001",
      "category": "instrumentation",
      "name": "Technical Measurement Kit",
      "type": "instrumentation",
      "status": "planned"
    }
  ]
}
JSON

# ==================================================
# INVENTORY
# ==================================================

cat > "$ROOT/market/inventory/inventory.json" <<'JSON'
{
  "locations": [],
  "items": []
}
JSON

# ==================================================
# SUPPLIERS
# ==================================================

cat > "$ROOT/market/suppliers/suppliers.json" <<'JSON'
{
  "suppliers": []
}
JSON

# ==================================================
# ORDERS
# ==================================================

cat > "$ROOT/market/orders/orders.json" <<'JSON'
{
  "orders": []
}
JSON

# ==================================================
# DELIVERY
# ==================================================

cat > "$ROOT/market/delivery/delivery.json" <<'JSON'
{
  "delivery_network": {
    "status": "architecture",
    "locations": [],
    "vehicles": [],
    "drivers": [],
    "routes": []
  }
}
JSON

# ==================================================
# TECHNICAL PROJECT BOM
# ==================================================

cat > "$ROOT/market/projects/bom.py" <<'PY'
#!/usr/bin/env python3

import json
import os
import sys
import uuid
from datetime import datetime

ROOT = os.path.expanduser("~/ScienceComputer")
PROJECT_ROOT = os.path.join(ROOT, "market", "projects")

def create():

    name = input("Project name: ").strip()

    if not name:
        print("Project name required.")
        return

    project_id = "BOM-" + uuid.uuid4().hex[:8].upper()

    path = os.path.join(
        PROJECT_ROOT,
        project_id + ".json"
    )

    bom = {
        "id": project_id,
        "project": name,
        "created": datetime.now().isoformat(),
        "items": [],
        "status": "draft"
    }

    with open(path, "w") as f:
        json.dump(bom, f, indent=2)

    print()
    print("Technical BOM created.")
    print("ID:", project_id)
    print("File:", path)

def list_boms():

    print()
    print("TECHNICAL PROJECT BOMs")
    print("======================")

    files = [
        f for f in os.listdir(PROJECT_ROOT)
        if f.endswith(".json")
    ]

    if not files:
        print("No BOMs.")
        return

    for file in sorted(files):

        with open(os.path.join(PROJECT_ROOT, file)) as f:
            bom = json.load(f)

        print(
            bom["id"],
            "-",
            bom["project"],
            "-",
            bom["status"]
        )

def main():

    if len(sys.argv) < 2:
        print("bom create")
        print("bom list")
        return

    if sys.argv[1] == "create":
        create()

    elif sys.argv[1] == "list":
        list_boms()

if __name__ == "__main__":
    main()
PY

chmod +x "$ROOT/market/projects/bom.py"

# ==================================================
# MARKET ENGINE
# ==================================================

cat > "$ROOT/market/market.py" <<'PY'
#!/usr/bin/env python3

import json
import os
import sys

ROOT = os.path.expanduser("~/ScienceComputer")
MARKET = os.path.join(ROOT, "market")

def load(file):

    with open(file) as f:
        return json.load(f)

def catalog():

    data = load(
        os.path.join(
            MARKET,
            "catalog",
            "products.json"
        )
    )

    print()
    print("SCIENCE COMPUTER TECHNICAL MARKET")
    print("=================================")
    print()

    for p in data["products"]:

        print(
            p["id"],
            "|",
            p["category"],
            "|",
            p["name"],
            "|",
            p["status"]
        )

def categories():

    data = load(
        os.path.join(
            MARKET,
            "market.json"
        )
    )

    print()
    print("TECHNICAL MARKET CATEGORIES")
    print("===========================")
    print()

    for category in data["categories"]:
        print("  ", category)

def status():

    data = load(
        os.path.join(
            MARKET,
            "market.json"
        )
    )

    print()
    print("SCIENCE COMPUTER TECHNICAL MARKET")
    print("=================================")
    print()
    print("Version:", data["version"])
    print("Purpose:", data["purpose"])
    print()

    print("Categories:", len(data["categories"]))
    print("Services:", len(data["services"]))

def bom():

    script = os.path.join(
        MARKET,
        "projects",
        "bom.py"
    )

    os.system(
        f'python "{script}"'
    )

def main():

    command = sys.argv[1] if len(sys.argv) > 1 else "status"

    if command == "catalog":
        catalog()

    elif command == "categories":
        categories()

    elif command == "status":
        status()

    elif command == "bom":
        bom()

    else:
        print("""
SCIENCE COMPUTER TECHNICAL MARKET

Commands:

  sc-market status
  sc-market catalog
  sc-market categories
  sc-market bom

The marketplace architecture connects:

  ScienceComputer
       ↓
  Technical Project
       ↓
  Bill of Materials
       ↓
  Products
       ↓
  Inventory
       ↓
  Procurement
       ↓
  Delivery
""")

if __name__ == "__main__":
    main()
PY

chmod +x "$ROOT/market/market.py"

# ==================================================
# COMMAND
# ==================================================

cat > "$HOME/bin/sc-market" <<'SH'
#!/data/data/com.termux/files/usr/bin/bash
exec python "$HOME/ScienceComputer/market/market.py" "$@"
SH

chmod +x "$HOME/bin/sc-market"

# ==================================================
# CONNECT MARKET TO MASTER COMMAND
# ==================================================

if [ -f "$HOME/bin/sc" ]; then

python - <<'PY'
from pathlib import Path

p = Path.home() / "bin" / "sc"
text = p.read_text()

if '"$HOME/bin/sc-market"' not in text:

    text = text.replace(
        'case "$1" in',
        'case "$1" in\n'
        '  market)\n'
        '    exec "$HOME/bin/sc-market" "${@:2}"\n'
        '    ;;\n'
    )

    p.write_text(text)
PY

fi

# ==================================================
# COMPANY DEFINITION
# ==================================================

cat > "$ROOT/market/COMPANY.md" <<'DOC'
# ScienceComputer Technical Company

## Mission

Make technical computing, technical equipment, components,
instruments, materials, software, and technical services accessible
through one connected system.

## Core

ScienceComputer is the computing platform.

## Market

ScienceComputer Technical Market is the technical store.

## Delivery

ScienceComputer Technical Delivery is the future fulfillment network.

## AI

ScienceComputer AI connects a user's technical objective with:

- computing
- engineering
- software
- components
- instruments
- materials
- project plans
- bills of materials
- procurement
- delivery

## Long-term model

OBJECTIVE
    ↓
AI
    ↓
TECHNICAL DESIGN
    ↓
PROJECT
    ↓
BOM
    ↓
PRODUCTS
    ↓
SUPPLIERS
    ↓
INVENTORY
    ↓
DELIVERY
    ↓
BUILD
    ↓
TEST
    ↓
RESULT
DOC

# ==================================================
# TEST
# ==================================================

echo
echo "=========================================="
echo " TESTING TECHNICAL MARKET"
echo "=========================================="

"$HOME/bin/sc-market" status

echo
"$HOME/bin/sc-market" catalog

echo
"$HOME/bin/sc-market" categories

# ==================================================
# GITHUB
# ==================================================

cd "$ROOT"

git add .

git commit -m "Add ScienceComputer Technical Market" || true

git push origin main

echo
echo "=========================================="
echo " TECHNICAL MARKET COMPLETE"
echo "=========================================="
echo
echo "Run:"
echo
echo "  sc-market"
echo "  sc-market catalog"
echo "  sc-market categories"
echo "  sc-market status"
echo
echo "Or:"
echo
echo "  sc market"
echo
echo "Create a technical project BOM:"
echo
echo "  sc-market bom"
echo
echo "GitHub synchronized."
