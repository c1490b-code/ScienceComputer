#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <cstdio>

int main() {
    Display *display = XOpenDisplay(":0");

    if (!display) {
        std::fprintf(stderr, "Cannot connect to Termux:X11\n");
        return 1;
    }

    int screen = DefaultScreen(display);
    Window root = RootWindow(display, screen);

    Window window = XCreateSimpleWindow(
        display, root,
        0, 0, 1200, 760, 2,
        WhitePixel(display, screen),
        BlackPixel(display, screen)
    );

    XStoreName(display, window, "ScienceComputer — Technical Computer");

    XSelectInput(
        display,
        window,
        ExposureMask | KeyPressMask | StructureNotifyMask
    );

    XMapWindow(display, window);

    GC gc = XCreateGC(display, window, 0, nullptr);

    bool running = true;

    while (running) {
        XEvent event;
        XNextEvent(display, &event);

        if (event.type == Expose) {
            XSetForeground(display, gc, WhitePixel(display, screen));

            XDrawString(display, window, gc, 45, 55,
                        "SCIENCE COMPUTER", 16);

            XDrawString(display, window, gc, 45, 85,
                        "TECHNICAL COMPUTER", 18);

            XDrawString(display, window, gc, 45, 135,
                        "ENGINEERING", 11);

            XDrawString(display, window, gc, 45, 175,
                        "TECHNICAL SCIENCE", 17);

            XDrawString(display, window, gc, 45, 215,
                        "TECHNICAL APPLICATIONS", 22);

            XDrawString(display, window, gc, 45, 255,
                        "APPLICATIONS", 12);

            XDrawString(display, window, gc, 45, 295,
                        "DEVELOPMENT", 12);

            XDrawString(display, window, gc, 45, 335,
                        "DESIGN", 6);

            XDrawString(display, window, gc, 45, 375,
                        "SIMULATION", 10);

            XDrawString(display, window, gc, 45, 415,
                        "DATA", 4);

            XDrawString(display, window, gc, 45, 455,
                        "INSTRUMENTATION", 16);

            XDrawString(display, window, gc, 45, 495,
                        "FABRICATION", 11);

            XDrawString(display, window, gc, 45, 560,
                        "TERMUX CORE", 11);

            XDrawString(display, window, gc, 45, 590,
                        "TERMUX:X11 DISPLAY", 19);

            XDrawString(display, window, gc, 45, 620,
                        "GitHub: c1490b-code/ScienceComputer", 35);

            XDrawString(display, window, gc, 45, 680,
                        "Press Q to close", 16);
        }

        if (event.type == KeyPress) {
            char buffer[32] = {};
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
    }

    XFreeGC(display, gc);
    XDestroyWindow(display, window);
    XCloseDisplay(display);

    return 0;
}
