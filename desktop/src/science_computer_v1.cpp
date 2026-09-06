#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <cstdio>
#include <cstring>

static void text(
    Display *d,
    Window w,
    GC gc,
    int x,
    int y,
    const char *s
) {
    XDrawString(d, w, gc, x, y, s, std::strlen(s));
}

int main() {

    Display *d = XOpenDisplay(":0");

    if (!d) {
        std::fprintf(stderr,
            "ScienceComputer: Termux:X11 unavailable.\n");
        return 1;
    }

    int screen = DefaultScreen(d);

    unsigned long black = BlackPixel(d, screen);
    unsigned long white = WhitePixel(d, screen);

    Window root = RootWindow(d, screen);

    Window w = XCreateSimpleWindow(
        d,
        root,
        0,
        0,
        1400,
        850,
        2,
        white,
        black
    );

    XStoreName(
        d,
        w,
        "ScienceComputer — Technical Computer"
    );

    XSelectInput(
        d,
        w,
        ExposureMask |
        KeyPressMask |
        ButtonPressMask |
        StructureNotifyMask
    );

    XMapWindow(d, w);

    GC gc = XCreateGC(d, w, 0, nullptr);

    bool running = true;

    while (running) {

        XEvent e;

        XNextEvent(d, &e);

        if (e.type == Expose) {

            XSetForeground(d, gc, white);

            /*
             * HEADER
             */

            text(
                d, w, gc,
                40, 45,
                "SCIENCE COMPUTER"
            );

            text(
                d, w, gc,
                40, 72,
                "TECHNICAL COMPUTER"
            );

            text(
                d, w, gc,
                1110, 45,
                "TERMUX"
            );

            text(
                d, w, gc,
                1110, 72,
                "X11"
            );

            /*
             * LEFT TECHNICAL NAVIGATION
             */

            text(
                d, w, gc,
                45, 130,
                "TECHNICAL"
            );

            text(
                d, w, gc,
                70, 170,
                "ENGINEERING"
            );

            text(
                d, w, gc,
                70, 210,
                "COMPUTING"
            );

            text(
                d, w, gc,
                70, 250,
                "SCIENCE"
            );

            text(
                d, w, gc,
                70, 290,
                "DESIGN"
            );

            text(
                d, w, gc,
                70, 330,
                "SIMULATION"
            );

            text(
                d, w, gc,
                70, 370,
                "INSTRUMENTATION"
            );

            text(
                d, w, gc,
                70, 410,
                "FABRICATION"
            );

            text(
                d, w, gc,
                70, 450,
                "DATA"
            );

            /*
             * ENGINEERING
             */

            text(
                d, w, gc,
                420, 130,
                "ENGINEERING WORKSPACE"
            );

            text(
                d, w, gc,
                420, 175,
                "SYSTEMS ENGINEERING"
            );

            text(
                d, w, gc,
                420, 215,
                "ELECTRICAL ENGINEERING"
            );

            text(
                d, w, gc,
                420, 255,
                "ELECTRONICS"
            );

            text(
                d, w, gc,
                420, 295,
                "MECHANICAL ENGINEERING"
            );

            text(
                d, w, gc,
                420, 335,
                "ROBOTICS"
            );

            text(
                d, w, gc,
                420, 375,
                "AEROSPACE"
            );

            text(
                d, w, gc,
                420, 415,
                "MANUFACTURING"
            );

            text(
                d, w, gc,
                420, 455,
                "CIVIL ENGINEERING"
            );

            /*
             * TECHNICAL APPLICATIONS
             */

            text(
                d, w, gc,
                820, 130,
                "TECHNICAL APPLICATIONS"
            );

            text(
                d, w, gc,
                820, 175,
                "CAD"
            );

            text(
                d, w, gc,
                820, 215,
                "3D MODELING"
            );

            text(
                d, w, gc,
                820, 255,
                "SCIENTIFIC COMPUTING"
            );

            text(
                d, w, gc,
                820, 295,
                "SIMULATION"
            );

            text(
                d, w, gc,
                820, 335,
                "DATA ANALYSIS"
            );

            text(
                d, w, gc,
                820, 375,
                "INSTRUMENTATION"
            );

            text(
                d, w, gc,
                820, 415,
                "TECHNICAL EDITOR"
            );

            /*
             * COMPUTER
             */

            text(
                d, w, gc,
                420, 550,
                "COMPUTER"
            );

            text(
                d, w, gc,
                420, 590,
                "APPLICATIONS"
            );

            text(
                d, w, gc,
                420, 630,
                "DEVELOPMENT"
            );

            text(
                d, w, gc,
                420, 670,
                "FILES"
            );

            text(
                d, w, gc,
                420, 710,
                "TERMINAL"
            );

            text(
                d, w, gc,
                820, 550,
                "GITHUB"
            );

            text(
                d, w, gc,
                820, 590,
                "PROJECTS"
            );

            text(
                d, w, gc,
                820, 630,
                "BUILD SYSTEM"
            );

            text(
                d, w, gc,
                820, 670,
                "COMPILER"
            );

            text(
                d, w, gc,
                820, 710,
                "DEBUGGER"
            );

            /*
             * FOOTER
             */

            text(
                d, w, gc,
                40, 805,
                "ScienceComputer v0.1"
            );

            text(
                d, w, gc,
                330, 805,
                "Runtime: Termux"
            );

            text(
                d, w, gc,
                560, 805,
                "Display: Termux:X11"
            );

            text(
                d, w, gc,
                850, 805,
                "Technical Computer"
            );

            text(
                d, w, gc,
                1110, 805,
                "Q = EXIT"
            );
        }

        if (e.type == KeyPress) {

            char buffer[32] = {};

            KeySym key;

            XLookupString(
                &e.xkey,
                buffer,
                sizeof(buffer),
                &key,
                nullptr
            );

            if (
                buffer[0] == 'q' ||
                buffer[0] == 'Q'
            ) {
                running = false;
            }
        }
    }

    XFreeGC(d, gc);
    XDestroyWindow(d, w);
    XCloseDisplay(d);

    return 0;
}
