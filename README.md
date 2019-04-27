# Tempus
Written by Calum Lindsay.  
 I wrote this to test out a time travel puzzle game idea but there's not a lot to it at the moment. There possibly never will be as I mostly got what I wanted from it. This was completely written without any intention of anyone reading it or even trying to comprehend it so it may have strange quirks here and there and certainly isn't completely thought through.

## How to run it
You will need the LÖVE Engine to run it which you can get [here](https://love2d.org "LÖVE 2D's Homepage"). Download any of the zipped versions, extract them and drag the folder containing Lovely Snake's source code onto the "love.exe" executable.

## Controls
- r reloads the script so you can make edits without closing and reopening LÖVE
- WASD to move around
- You are the blue square
- The red square is an Enemy
- The green squares are walls but there is no collision
- The white square at the top left allows you to go back in time and you'll see your previous self moving around.
- The Yellow squares are Doors and the purple square is an activator for the doors

## Possible future improvements / problems
- [x] Doors reset when going back in time
- [ ] Activators should be a part of the lvl file format
- [ ] Layers for abstracting input/drawing/updating
- [ ] Pause menu
- [ ] Tidy & comment
- [ ] General refactor 
- [ ] Collision detection
- [ ] Some levels with unique puzzles