package main

import rl "vendor:raylib"
import scr "screen"

// --- Module Variables Definition (local)
ending := scr.Screen {
    frameCounter = frameCounter,
    finishScreen = finishScreen,
    Init = Init,
    Update = Update,
    Draw = Draw,
    Unload = Unload,
    Finish = Finish,
}

@(private="file")
frameCounter, finishScreen := 0, 0

// --- Ending Screen Functions Definition

// Ending Screen Initialization logic
@(private="file")
Init :: proc() {
    // TODO: Initialize ENDING screen variables here!
    frameCounter = 0
    finishScreen = 0
}

// Ending Screen Update logic
@(private="file")
Update :: proc() { using rl, scr
    // TODO: Update ENDING screen variables here!

    // Press enter or tap to return to TITLE screen
    //if IsKeyPressed(.ENTER) || IsGestureDetected(.TAP) {
        finishScreen = 1
        PlaySound(fxCoin)
    //}
}

// Ending Screen Draw logic
@(private="file")
Draw :: proc() { using rl
    // TODO: Draw ENDING screen here!
    DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), BLUE)

    pos: Vector2 = { 20, 10 }
    DrawTextEx(font, "ENDING SCREEN", pos, f32(font.baseSize)*3.0, 4, DARKBLUE)
    DrawText("PRESS ENTER or ClICK the SCREEN to RETURN to TITLE SCREEN", 120, 220, 20, DARKBLUE)
}

// Ending Screen Unload logic
@(private="file")
Unload :: proc() {
    // TODO: Unload ENDING screen variables here!
}

// Ending Screen should finish?
@(private="file")
Finish :: proc() -> int {
    return finishScreen
}
