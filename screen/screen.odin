package screen

import rl "vendor:raylib"

// --- Types and Structures Definition
GameScreen :: enum {
    UNKNOWN = -1,
    LOGO = 0,
    TITLE,
    OPTIONS,
    GAMEPLAY,
    ENDING,
}

Screen :: struct {
    frameCounter: int,
    finishScreen: int,
    Init:   proc(),
    Update: proc(),
    Draw:   proc(),
    Unload: proc(),
    Finish: proc() -> int,
}

