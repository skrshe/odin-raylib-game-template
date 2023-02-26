//  raylib - Advance Game template
//  Copyright (c) 2014-2022 Ramon Santamaria (@raysan5)
package main

import rl "vendor:raylib"
import scr "screen"

logo := scr.Screen {
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
frameCounter, finishScreen:= 0, 0

logoPositionX :i32= 0
logoPositionY :i32= 0

lettersCount :i32= 0

topSideRecWidth :i32 = 0
leftSideRecHeight :i32= 0

bottomSideRecWidth :i32= 0
rightSideRecHeight :i32= 0

state := 0               // Logo animation states
alpha :f32= 1.0          // Useful for fading

// --- Logo Screen Functions Definition

// Logo Screen Initialization logic
@(private="file")
Init :: proc() { using rl
    finishScreen = 0
    frameCounter = 0
    lettersCount = 0

    logoPositionX = GetScreenWidth()/2 - 128
    logoPositionY = GetScreenHeight()/2 - 128

    topSideRecWidth = 16
    leftSideRecHeight = 16
    bottomSideRecWidth = 16
    rightSideRecHeight = 16

    state = 0
    alpha = 1.0
}

// Logo Screen Update logic
@(private="file")
Update :: proc() {
    if state == 0 {               // State 0: Top-left square corner blink logic
        frameCounter+=1

        if frameCounter == 80 {
            state = 1
            frameCounter = 0;      // Reset counter... will be used later...
        }
    } else if state == 1 {           // State 1: Bars animation logic: top and left
        topSideRecWidth += 8
        leftSideRecHeight += 8

        if topSideRecWidth == 256 do state = 2
    } else if state == 2 {           // State 2: Bars animation logic: bottom and right
        bottomSideRecWidth += 8
        rightSideRecHeight += 8

        if bottomSideRecWidth == 256 do state = 3
    } else if state == 3 {           // State 3: "raylib" text-write animation logic
        frameCounter+=1

        if lettersCount < 10 {
            if frameCounter%12 == 1 {   // Every 12 frame, one more letter!
                lettersCount+=1
                frameCounter = 0
            }
        } else {   // When all letters have appeared, just fade out everything

            if frameCounter > 200 {
                alpha -= 0.02

                if alpha <= 0.0 {
                    alpha = 0.0
                    finishScreen = 1   // Jump to next screen
                }
            }
        }
    }
}

// Logo Screen Draw logic
@(private="file")
Draw :: proc() { using rl
    if state == 0 {        // Draw blinking top-left square corner
        if ((frameCounter/10)%2 == 1) do DrawRectangle(logoPositionX, logoPositionY, 16, 16, BLACK)
    } else if state == 1 { // Draw bars animation: top and left
        DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
        DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)
    } else if (state == 2) {  // Draw bars animation: bottom and right
        DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
        DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)

        DrawRectangle(logoPositionX + 240, logoPositionY, 16, rightSideRecHeight, BLACK)
        DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16, BLACK)
    } else if (state == 3) {  // Draw "raylib" text-write animation + "powered by"
        DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, Fade(BLACK, alpha))
        DrawRectangle(logoPositionX, logoPositionY + 16, 16, leftSideRecHeight - 32, Fade(BLACK, alpha))

        DrawRectangle(logoPositionX + 240, logoPositionY + 16, 16, rightSideRecHeight - 32, Fade(BLACK, alpha))
        DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16, Fade(BLACK, alpha))

        DrawRectangle(GetScreenWidth()/2 - 112, GetScreenHeight()/2 - 112, 224, 224, Fade(RAYWHITE, alpha))

        DrawText(TextSubtext("raylib", 0, lettersCount), GetScreenWidth()/2 - 44, GetScreenHeight()/2 + 48, 50, Fade(BLACK, alpha))

        if (frameCounter > 20) do DrawText("powered by", logoPositionX, logoPositionY - 27, 20, Fade(DARKGRAY, alpha))
    }
}

// Logo Screen Unload logic
@(private="file")
Unload :: proc() {
    // Unload LOGO screen variables here!
}

// Logo Screen should finish?
@(private="file")
Finish :: proc() -> int { return finishScreen }
