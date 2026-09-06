#!/data/data/com.termux/files/usr/bin/bash
set -e

cd "$HOME/ScienceComputer"

echo "=== SCIENCE COMPUTER DESKTOP BUILD ==="

echo "[1/6] Enabling X11 repository..."
pkg install -y x11-repo

echo "[2/6] Installing native X11 development libraries..."
pkg install -y libx11 libxext

echo "[3/6] Creating desktop source..."
mkdir -p desktop/src desktop/bin

cat > desktop/src/science_desktop.cpp <<'CPP'
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>

int main() {
    Display *display = XOpenDisplay(nullptr);

    if (!display) {
        fprintf(stderr,
            "ScienceComputer: Cannot connect to X11.\n"
            "Start Termux:X11 and set DISPLAY=:0 first.\n");
        return 1;
    }

    int screen = DefaultScreen(display);
    Window root = RootWindow(display, screen);

    unsigned long background = BlackPixel(display, screen);
    unsigned long foreground = WhitePixel(display, screen);

    Window window = XCreateSimpleWindow(
        display,
        root,
        0, 0,
        1200, 760,
        1,
        foreground,
        background
    );

    XStoreName(display, window, "ScienceComputer");

    XSelectInput(
        display,
        window,
        ExposureMask |
        KeyPressMask |
        ButtonPressMask |
        StructureNotifyMask
    );

    XMapWindow(display, window);

    GC gc = XCreateGC(display, window, 0, nullptr);

    bool running = true;

    while (running) {
        XEvent event;
        XNextEvent(display, &event);

        if (event.type == Expose) {

            XSetForeground(display, gc, foreground);

            XDrawString(
                display,
                window,
                gc,
                40, 60,
                "SCIENCE COMPUTER",
                16
            );

            XDrawString(
                display,
                window,
                gc,
                40, 95,
                "Technical Computer Environment",
                31
            );

            XDrawString(
                display,
                window,
                gc,
                40, 160,
                "[ SCIENCE ]",
                11
            );

            XDrawString(
                display,
                window,
                gc,
                40, 210,
                "[ ENGINEERING ]",
                15
            );

            XDrawString(
                display,
                window,
                gc,
                40, 260,
                "[ DESIGN ]",
                10
            );

            XDrawString(
                display,
                window,
                gc,
                40, 310,
                "[ SIMULATION ]",
                14
            );

            XDrawString(
                display,
                window,
                gc,
                40, 360,
                "[ DEVELOPMENT ]",
                15
            );

            XDrawString(
                display,
                window,
                gc,
                40, 410,
                "[ FILES ]",
                8
            );

            XDrawString(
                display,
                window,
                gc,
                40, 460,
                "[ TERMINAL ]",
                11
            );

            XDrawString(
                display,
                window,
                gc,
                40, 540,
                "SCIENCE COMPUTER CORE",
                21
            );

            XDrawString(
                display,
                window,
                gc,
                40, 575,
                "Runtime: Termux",
                15
            );

            XDrawString(
                display,
                window,
                gc,
                40, 610,
                "Display: Termux:X11",
                19
            );

            XDrawString(
                display,
                window,
                gc,
                40, 645,
                "GitHub: c1490b-code/ScienceComputer",
                36
            );
        }

        if (event.type == KeyPress) {
            char buffer[32];
            KeySym key;
            XLookupString(
                &event.xkey,
                buffer,
                sizeof(buffer),
                &key,
                nullptr
            );

            if (buffer[0] == 'q' || buffer[0] == 'Q') {
                running = false;
            }
        }

        if (event.type == ClientMessage) {
            running = false;
        }
    }

    XFreeGC(display, gc);
    XDestroyWindow(display, window);
    XCloseDisplay(display);

    return 0;
}
CPP

echo "[4/6] Compiling native desktop..."

clang++ \
    -std=c++20 \
    desktop/src/science_desktop.cpp \
    -lX11 \
    -lXext \
    -o desktop/bin/science-desktop

echo "[5/6] Creating launcher..."

cat > scripts/start-desktop.sh <<'START'
#!/data/data/com.termux/files/usr/bin/bash

export DISPLAY=:0

echo "Starting ScienceComputer Desktop..."
echo "DISPLAY=$DISPLAY"

if ! "$HOME/ScienceComputer/desktop/bin/science-desktop"; then
    echo
    echo "ScienceComputer could not connect to Termux:X11."
    echo
    echo "Make sure the Termux:X11 application is open."
    echo "Then run:"
    echo
    echo "export DISPLAY=:0"
    echo "$HOME/ScienceComputer/scripts/start-desktop.sh"
    exit 1
fi
START

chmod +x scripts/start-desktop.sh

echo "[6/6] Saving to GitHub..."

git add .
git commit -m "Build native ScienceComputer X11 desktop v0.1" || true
git push

echo
echo "=========================================="
echo " SCIENCE COMPUTER DESKTOP BUILT"
echo "=========================================="
echo
echo "Start Termux:X11 first."
echo
echo "Then run:"
echo
echo "  export DISPLAY=:0"
echo "  ~/ScienceComputer/scripts/start-desktop.sh"
echo
echo "Press Q inside the desktop to exit."
