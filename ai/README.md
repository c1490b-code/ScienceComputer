# ScienceComputer AI

AI is a subsystem of ScienceComputer.

The AI engine is independent of the desktop.

Current architecture:

Termux
  |
ScienceComputer Core
  |
AI Core
  |
Technical Systems
  |
Applications
  |
Desktop / Termux:X11

The desktop will connect to this AI engine rather than replace it.

The model-provider layer is deliberately separated from the computer
core so local models, remote APIs, or future AI systems can be added
without redesigning ScienceComputer.
