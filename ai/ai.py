#!/usr/bin/env python3

import os
import sys
import json
import datetime
import subprocess
import shutil

ROOT = os.path.expanduser("~/ScienceComputer")
AI_ROOT = os.path.join(ROOT, "ai")
CONFIG = os.path.join(AI_ROOT, "config", "ai.json")
LOG = os.path.join(AI_ROOT, "logs", "ai.log")

def load_config():
    with open(CONFIG) as f:
        return json.load(f)

def log(message):
    os.makedirs(os.path.dirname(LOG), exist_ok=True)

    with open(LOG, "a") as f:
        f.write(
            datetime.datetime.now().isoformat()
            + " "
            + message
            + "\n"
        )

def workspace():
    return os.path.join(ROOT, "workspace")

def status():
    cfg = load_config()

    print()
    print("SCIENCE COMPUTER AI")
    print("==================")
    print()
    print("Version:", cfg["version"])
    print("Mode:", cfg["mode"])
    print("Terminal:", cfg["terminal_ready"])
    print("Desktop ready:", cfg["desktop_ready"])
    print()

    print("Capabilities:")
    for name, enabled in cfg["capabilities"].items():
        print("  %-20s %s" % (name, "ON" if enabled else "OFF"))

    print()
    print("Permissions:")

    for name, enabled in cfg["permissions"].items():
        print("  %-20s %s" % (name, "ON" if enabled else "OFF"))

def projects():
    path = os.path.join(workspace(), "projects")

    print()
    print("SCIENCE COMPUTER PROJECTS")
    print("=========================")
    print()

    if not os.path.exists(path):
        print("No projects directory.")
        return

    items = os.listdir(path)

    if not items:
        print("No projects yet.")
        return

    for item in sorted(items):
        print("  ", item)

def files():
    path = workspace()

    print()
    print("SCIENCE COMPUTER WORKSPACE")
    print("==========================")
    print()

    for root, dirs, filenames in os.walk(path):
        level = root.replace(path, "").count(os.sep)

        if level > 2:
            continue

        indent = "  " * level

        print(indent + os.path.basename(root) + "/")

        for filename in sorted(filenames)[:30]:
            print(indent + "  " + filename)

def tools():
    print()
    print("SCIENCE COMPUTER TOOLCHAIN")
    print("==========================")
    print()

    commands = [
        "python",
        "clang",
        "clang++",
        "git",
        "gh",
        "node",
        "rustc"
    ]

    for command in commands:
        path = shutil.which(command)

        if path:
            print("  %-10s %s" % (command, path))
        else:
            print("  %-10s NOT INSTALLED" % command)

def technical():
    print()
    print("AI TECHNICAL INTERFACE")
    print("======================")
    print()
    print("Available technical systems:")
    print()
    print("  engineering")
    print("  electronics")
    print("  physics")
    print("  math")
    print("  simulation")
    print("  robotics")
    print("  data")
    print("  development")
    print("  design")
    print("  instrumentation")
    print()
    print("AI can act as the coordinating layer")
    print("between these systems.")
    print()

def providers():
    path = os.path.join(AI_ROOT, "models")

    print()
    print("AI MODEL PROVIDERS")
    print("==================")
    print()

    if not os.path.exists(path):
        print("No providers registered.")
        return

    items = os.listdir(path)

    if not items:
        print("No model providers registered yet.")
        print()
        print("The architecture is ready for:")
        print("  local models")
        print("  remote APIs")
        print("  future providers")
        return

    for item in items:
        print("  ", item)

def ask():
    print()
    print("SCIENCE COMPUTER AI")
    print("==================")
    print()
    print("Core AI interface is online.")
    print("This layer currently provides the computer")
    print("context and technical-system interface.")
    print()
    print("A model provider can be connected later.")
    print()
    print("Commands:")
    print("  status")
    print("  projects")
    print("  files")
    print("  tools")
    print("  technical")
    print("  providers")
    print("  exit")
    print()

    while True:
        try:
            text = input("ai> ").strip()
        except EOFError:
            break

        if not text:
            continue

        if text in ("exit", "quit"):
            break

        if text == "status":
            status()

        elif text == "projects":
            projects()

        elif text == "files":
            files()

        elif text == "tools":
            tools()

        elif text == "technical":
            technical()

        elif text == "providers":
            providers()

        else:
            print("AI core received:", text)
            print("Model provider not connected yet.")

        log("USER: " + text)

def main():
    if len(sys.argv) < 2:
        ask()
        return

    command = sys.argv[1].lower()

    if command == "status":
        status()
    elif command == "projects":
        projects()
    elif command == "files":
        files()
    elif command == "tools":
        tools()
    elif command == "technical":
        technical()
    elif command == "providers":
        providers()
    elif command == "ask":
        ask()
    else:
        print("Unknown AI command:", command)

if __name__ == "__main__":
    main()
