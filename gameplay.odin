package main

import rl "vendor:raylib"
import scr "screen"

game := scr.Screen {
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
frameCounter, finishScreen  := 0, 0

// --- Gameplay Screen Functions Definition

// Gameplay Screen Initialization logic
@(private="file")
Init :: proc() {
    // TODO: Initialize GAMEPLAY screen variables here!
    frameCounter = 0
    finishScreen = 0
}

// Gameplay Screen Update logic
@(private="file")
Update :: proc() { using rl, scr
    // TODO: Update GAMEPLAY screen variables here!

    // Press enter or tap to change to ENDING screen
    //if IsKeyPressed(.ENTER) || IsGestureDetected(.TAP) {
        finishScreen = 1
        PlaySound(fxCoin)
    //}
}

// Gameplay Screen Draw logic
@(private="file")
Draw :: proc() { using rl, scr
    // TODO: Draw GAMEPLAY screen here!
    DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), PURPLE)
    pos: Vector2 = { 20, 10 }
    DrawTextEx(font, "GAMEPLAY SCREEN", pos, f32(font.baseSize)*3.0, 4, MAROON)
    DrawText("PRESS ENTER or TAP to JUMP to ENDING SCREEN", 130, 220, 20, MAROON)
}

// Gameplay Screen Unload logic
@(private="file")
Unload :: proc() {
    // TODO: Unload GAMEPLAY screen variables here!
}

// Gameplay Screen should finish?
@(private="file")
Finish :: proc() -> int {
    return finishScreen
}
