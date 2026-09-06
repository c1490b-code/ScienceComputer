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
