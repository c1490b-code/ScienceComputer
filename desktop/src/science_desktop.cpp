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
