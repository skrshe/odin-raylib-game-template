package main

import rl "vendor:raylib"
import scr "screen"

options := scr.Screen {
    frameCounter = frameCounter,
    finishScreen = finishScreen,
    Init = Init,
    Update = Update,
    Draw = Draw,
    Unload = Unload,
    Finish = Finish,
}

// --- Module Variables Definition (local)
@(private="file")
frameCounter, finishScreen := 0, 0

// --- Options Screen Functions Definition

// Options Screen Initialization logic
@(private="file")
Init :: proc() {
    // TODO: Initialize OPTIONS screen variables here!
    frameCounter = 0
    finishScreen = 0
}

// Options Screen Update logic
@(private="file")
Update :: proc() {
    // TODO: Update OPTIONS screen variables here!
}

// Options Screen Draw logic
@(private="file")
Draw :: proc() {
    // TODO: Draw OPTIONS screen here!
}

// Options Screen Unload logic
@(private="file")
Unload :: proc() {
    // TODO: Unload OPTIONS screen variables here!
}

// Options Screen should finish?
@(private="file")
Finish :: proc() -> int { return finishScreen }
