#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOT="$HOME/ScienceComputer"

echo "=========================================="
echo " SCIENCE COMPUTER — DESKTOP BUILD"
echo "=========================================="

mkdir -p "$ROOT/desktop/src" "$ROOT/desktop/bin"

# --------------------------------------------------
# INSTALL X11 BUILD DEPENDENCY
# --------------------------------------------------

pkg install -y libx11 libxext clang

# --------------------------------------------------
# DESKTOP SOURCE
# --------------------------------------------------

cat > "$ROOT/desktop/src/science_desktop.cpp" <<'CPP'
#include <X11/Xlib.h>
#include <X11/Xutil.h>

#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>

struct App {
    std::string name;
    std::string command;
};

static std::vector<App> apps = {
    {"AI",             "sc-ai"},
    {"Engineering",    "engineering"},
    {"Electronics",    "electronics"},
    {"Physics",        "physics"},
    {"Mathematics",    "math"},
    {"Simulation",     "simulation"},
    {"Robotics",       "robotics"},
    {"Development",    "sc development"},
    {"Technical",      "sc technical"},
    {"Files",          "sc files"},
    {"System",         "sc-system"},
    {"Projects",       "sc project"}
};

int main() {

    Display *display = XOpenDisplay(nullptr);

    if (!display) {
        std::cerr << "ScienceComputer: X11 display unavailable.\n";
        std::cerr << "Start Termux:X11 and set DISPLAY=:0.\n";
        return 1;
    }

    int screen = DefaultScreen(display);

    Window root = RootWindow(display, screen);

    unsigned long black = BlackPixel(display, screen);
    unsigned long white = WhitePixel(display, screen);

    int width = 1100;
    int height = 700;

    Window window = XCreateSimpleWindow(
        display,
        root,
        50,
        50,
        width,
        height,
        1,
        black,
        white
    );

    XStoreName(
        display,
        window,
        "ScienceComputer"
    );

    XSelectInput(
        display,
        window,
        ExposureMask |
        KeyPressMask |
        ButtonPressMask |
        StructureNotifyMask
    );

    Atom deleteWindow =
        XInternAtom(
            display,
            "WM_DELETE_WINDOW",
            False
        );

    XSetWMProtocols(
        display,
        window,
        &deleteWindow,
        1
    );

    XMapWindow(display, window);

    GC gc = XCreateGC(
        display,
        window,
        0,
        nullptr
    );

    XEvent event;

    bool running = true;

    while (running) {

        XNextEvent(display, &event);

        if (event.type == ClientMessage) {

            if ((Atom)event.xclient.data.l[0] ==
                deleteWindow) {

                running = false;
            }
        }

        if (event.type == ConfigureNotify) {

            width = event.xconfigure.width;
            height = event.xconfigure.height;
        }

        if (event.type == Expose) {

            XClearWindow(display, window);

            // Header
            XDrawString(
                display,
                window,
                gc,
                35,
                45,
                "SCIENCE COMPUTER",
                16
            );

            XDrawString(
                display,
                window,
                gc,
                35,
                70,
                "Technical Computer Environment",
                31
            );

            XDrawString(
                display,
                window,
                gc,
                35,
                100,
                "Termux / ScienceComputer Core / AI",
                35
            );

            // Application grid
            int startX = 40;
            int startY = 145;

            int buttonWidth = 220;
            int buttonHeight = 70;

            int columns = 4;

            for (size_t i = 0; i < apps.size(); ++i) {

                int col = i % columns;
                int row = i / columns;

                int x = startX + col * (buttonWidth + 20);
                int y = startY + row * (buttonHeight + 20);

                XDrawRectangle(
                    display,
                    window,
                    gc,
                    x,
                    y,
                    buttonWidth,
                    buttonHeight
                );

                XDrawString(
                    display,
                    window,
                    gc,
                    x + 20,
                    y + 30,
                    apps[i].name.c_str(),
                    apps[i].name.length()
                );

                XDrawString(
                    display,
                    window,
                    gc,
                    x + 20,
                    y + 52,
                    "Launch",
                    6
                );
            }

            // Status
            XDrawString(
                display,
                window,
                gc,
                40,
                height - 45,
                "SCIENCE COMPUTER CORE ONLINE",
                28
            );

            XFlush(display);
        }

        if (event.type == ButtonPress) {

            int mx = event.xbutton.x;
            int my = event.xbutton.y;

            int startX = 40;
            int startY = 145;

            int buttonWidth = 220;
            int buttonHeight = 70;

            int columns = 4;

            for (size_t i = 0; i < apps.size(); ++i) {

                int col = i % columns;
                int row = i / columns;

                int x = startX + col * (buttonWidth + 20);
                int y = startY + row * (buttonHeight + 20);

                bool inside =
                    mx >= x &&
                    mx <= x + buttonWidth &&
                    my >= y &&
                    my <= y + buttonHeight;

                if (inside) {

                    std::string command =
                        apps[i].command;

                    std::string terminal =
                        "termux-open-url "
                        "\"file:///dev/null\" "
                        ">/dev/null 2>&1; ";

                    // Launch through the Android/Termux
                    // command environment.
                    std::string launch =
                        "sh -c '" +
                        command +
                        "' >/dev/null 2>&1 &";

                    std::system(
                        launch.c_str()
                    );

                    break;
                }
            }
        }

        if (event.type == KeyPress) {

            char buffer[32];

            KeySym key;

            int count =
                XLookupString(
                    &event.xkey,
                    buffer,
                    sizeof(buffer),
                    &key,
                    nullptr
                );

            if (count > 0) {

                if (buffer[0] == 'q' ||
                    buffer[0] == 'Q') {

                    running = false;
                }
            }
        }
    }

    XFreeGC(display, gc);

    XDestroyWindow(display, window);

    XCloseDisplay(display);

    return 0;
}
CPP

# --------------------------------------------------
# COMPILE
# --------------------------------------------------

echo
echo "Compiling ScienceComputer desktop..."

clang++ \
    -std=c++17 \
    -O2 \
    "$ROOT/desktop/src/science_desktop.cpp" \
    -o "$ROOT/desktop/bin/science-desktop" \
    -lX11 \
    -lXext

chmod +x "$ROOT/desktop/bin/science-desktop"

# --------------------------------------------------
# DESKTOP LAUNCHER
# --------------------------------------------------

cat > "$ROOT/desktop/start.sh" <<'SH'
#!/data/data/com.termux/files/usr/bin/bash

ROOT="$HOME/ScienceComputer"

if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

echo "Starting ScienceComputer Desktop..."
echo "DISPLAY=$DISPLAY"

exec "$ROOT/desktop/bin/science-desktop"
SH

chmod +x "$ROOT/desktop/start.sh"

ln -sf "$ROOT/desktop/start.sh" "$HOME/bin/science-desktop"

# --------------------------------------------------
# DESKTOP INFORMATION
# --------------------------------------------------

cat > "$ROOT/desktop/README.md" <<'DOC'
# ScienceComputer Desktop

Native C++ X11 graphical shell for ScienceComputer.

The desktop is a front end.

The actual computer remains underneath it:

ScienceComputer Core
AI
Technical Systems
Applications
Workspace

The desktop does not replace those systems.

Termux:X11 provides the display server.
DOC

# --------------------------------------------------
# TEST FILE
# --------------------------------------------------

cat > "$ROOT/desktop/test.sh" <<'SH'
#!/data/data/com.termux/files/usr/bin/bash

if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

echo "ScienceComputer X11 test"
echo "DISPLAY=$DISPLAY"

if "$HOME/ScienceComputer/desktop/bin/science-desktop"; then
    echo "Desktop exited normally."
else
    echo "Desktop could not start."
    exit 1
fi
SH

chmod +x "$ROOT/desktop/test.sh"

# --------------------------------------------------
# GITHUB
# --------------------------------------------------

cd "$ROOT"

git add .

git commit -m "Add native ScienceComputer X11 desktop" || true

git push origin main

echo
echo "=========================================="
echo " DESKTOP BUILD COMPLETE"
echo "=========================================="
echo
echo "Start Termux:X11 first."
echo
echo "Then run:"
echo
echo "  export DISPLAY=:0"
echo "  science-desktop"
echo
echo "Or:"
echo
echo "  ~/ScienceComputer/desktop/start.sh"
echo
echo "Press Q to close the desktop."
echo
echo "GitHub synchronized."
