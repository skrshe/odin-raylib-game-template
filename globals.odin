package main

import rl "vendor:raylib"
import scr "screen"

screenWidth  :: 800
screenHeight :: 450

currentScreen: scr.GameScreen

font:   rl.Font
music:  rl.Music
fxCoin: rl.Sound


// Required variables to manage screen transitions (fade-in, fade-out)
transAlpha: f32 = 0
onTransition:= false
transFadeOut:= false
transFromScreen: scr.GameScreen
transToScreen: scr.GameScreen
