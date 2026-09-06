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
