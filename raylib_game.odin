//  raylib game template in odin
//
//  <Game title>
//  <Game description>
//
//  Copyright (c) 2021 Ramon Santamaria (@raysan5)
package main

import rl "vendor:raylib"
import scr "screen" // NOTE: Declares global (extern) variables and screens functions

main :: proc() { using rl; using scr
    // --- Initialization
    InitWindow(screenWidth, screenHeight, "raylib game template in odin")
    defer CloseWindow()

    InitAudioDevice()      // Initialize audio device
    defer CloseAudioDevice()     // Close audio context

    // Load global data (assets that must be available in all screens, i.e. font)
    font = LoadFont("resources/mecha.png")
    music = LoadMusicStream("resources/ambient.ogg")
    fxCoin = LoadSound("resources/coin.wav")

    SetMusicVolume(music, 1.0)
    PlayMusicStream(music)

    // Setup and init first screen
    currentScreen = .LOGO
    logo.Init()


    SetTargetFPS(60);       // Set our game to run at 60 frames-per-second

    // Main game loop
    for !WindowShouldClose() { // Detect window close button or ESC key
        UpdateDrawFrame()
    }

    // --- De-Initialization
    // Unload current screen data before closing
    #partial switch currentScreen {
    case .LOGO: logo.Unload()
    case .TITLE: title.Unload()
    case .GAMEPLAY: game.Unload()
    case .ENDING: ending.Unload()
    }

    // Unload global data loaded
    UnloadFont(font)
    UnloadMusicStream(music)
    UnloadSound(fxCoin)


}

// --- Module specific Functions Definition
// Change to next screen, no transition
ChangeToScreen :: proc(screen: scr.GameScreen) { using scr
    // Unload current screen
    #partial switch currentScreen {
    case .LOGO: logo.Unload()
    case .TITLE: logo.Unload()
    case .GAMEPLAY: logo.Unload()
    case .ENDING: logo.Unload()
    }

    // Init next screen
    #partial switch screen {
    case .LOGO: logo.Init()
    case .TITLE: title.Init()
    case .GAMEPLAY: game.Init()
    case .ENDING: ending.Init()
    }

    currentScreen = screen
}

// Request transition to next screen
TransitionToScreen :: proc(screen: scr.GameScreen) { using scr
    onTransition = true
    transFadeOut = false
    transFromScreen = currentScreen
    transToScreen = screen
    transAlpha = 0.0
}

// Update transition effect (fade-in, fade-out)
UpdateTransition :: proc() {
    using rl
    if !transFadeOut {
        transAlpha += 0.05

        // NOTE: Due to float internal representation, condition jumps on 1.0 instead of 1.05
        // For that reason we compare against 1.01, to avoid last frame loading stop
        if transAlpha > 1.01 {
            transAlpha = 1.0

            // Unload current screen
            #partial switch transFromScreen {
            case .LOGO: logo.Unload()
            case .TITLE: title.Unload()
            case .OPTIONS: options.Unload()
            case .GAMEPLAY: game.Unload()
            case .ENDING: ending.Unload()
            }

            // Load next screen
            #partial switch transToScreen {
            case .LOGO: logo.Init()
            case .TITLE: title.Init()
            case .GAMEPLAY: game.Init()
            case .ENDING: ending.Init()
            }

            currentScreen = transToScreen

            // Activate fade out effect to next loaded screen
            transFadeOut = true
        }
    } else { // Transition fade out logic
        transAlpha -= 0.02

        if transAlpha < -0.01 {
            transAlpha = 0.0
            transFadeOut = false
            onTransition = false
            transFromScreen = .UNKNOWN
            transToScreen = .UNKNOWN
        }
    }
}

// Draw transition effect (full-screen rectangle)
DrawTransition :: proc() { using rl
    DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(BLACK, transAlpha))
}

// Update and draw game frame
UpdateDrawFrame :: proc() { using rl, scr
    // --- Update
    UpdateMusicStream(music);       // NOTE: Music keeps playing between screens

    if !onTransition { using scr.GameScreen
        #partial switch currentScreen {
        case .LOGO:
            logo.Update()
            if (logo.Finish() != 0) do TransitionToScreen(.TITLE)
            return
        case .TITLE:
            title.Update()
            if (title.Finish() == 1) do TransitionToScreen(.OPTIONS)
            else if (title.Finish() == 2) do TransitionToScreen(.GAMEPLAY)
            return
        case .OPTIONS:
            title.Update()
            if (options.Finish()) != 0   do TransitionToScreen(.TITLE)
            return
        case .GAMEPLAY:
            game.Update()
            if game.Finish() == 1  do TransitionToScreen(.ENDING)
            //else if (Finish() == 2) TransitionToScreen(TITLE)
            return
        case .ENDING:
            ending.Update()
            if (ending.Finish() == 1) do TransitionToScreen(.TITLE) }
            return
    } else do UpdateTransition()    // Update transition (fade-in, fade-out)

    // --- Draw
    BeginDrawing(); defer EndDrawing(); {
        ClearBackground(RAYWHITE)

        #partial switch currentScreen {
        case .LOGO: logo.Draw()
        case .TITLE: title.Draw()
        case .OPTIONS: options.Draw()
        case .GAMEPLAY: game.Draw()
        case .ENDING: ending.Draw()
        }

        // Draw full screen rectangle in front of everything
        if onTransition do DrawTransition()

        //DrawFPS(10, 10)
    }
}
