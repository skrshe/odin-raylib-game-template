package main

import "core:fmt"
import rl "vendor:raylib"
import scr "screen"

title := scr.Screen {
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

// --- Title Screen Functions Definition

// Title Screen Initialization logic
@(private="file")
Init :: proc() {
    // TODO: Initialize TITLE screen variables here!
    frameCounter = 0
    finishScreen = 0
}

// Title Screen Update logic
@(private="file")
Update :: proc() { using rl
    // TODO: Update TITLE screen variables here!

    // Press enter or tap to change to GAMEPLAY screen
    if IsKeyPressed(.ENTER) ||  IsGestureDetected(.TAP) {
        //finishScreen = 1;   // OPTIONS
        finishScreen = 2      // GAMEPLAY
        PlaySound(fxCoin)
        fmt.printf("!!!FUCK!!!")
    }
}

// Title Screen Draw logic
@(private="file")
Draw :: proc() { using rl
    // TODO: Draw TITLE screen here!
    DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), GREEN)
    pos:= Vector2 { 20, 10 }
    DrawTextEx(font, "TITLE SCREEN", pos, f32(font.baseSize)*3.0, 4, DARKGREEN)
    DrawText("PRESS ENTER or TAP to JUMP to GAMEPLAY SCREEN", 120, 220, 20, DARKGREEN)
}

@(private="file")
Unload :: proc() {
    // TODO: Unload TITLE screen variables here!
}

// Title Screen should finish?
@(private="file")
Finish :: proc() -> int {
    return finishScreen
}
