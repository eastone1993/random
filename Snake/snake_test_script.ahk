#Persistent
#SingleInstance, force 

img := A_ScriptDir . "\apple.png"

Gui, Add, Picture, x500 y500 h100 w100 vTest, % img 

Gui, Show, w1000 h1000

return 

Esc::
GuiClose:
ExitApp 

p::
GuiControl, Move, Test, x100 y100 h100 w100
return