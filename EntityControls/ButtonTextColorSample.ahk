; ----------------------------------------------------------------------------------------------------------------------
; AHK 1.1+
; ----------------------------------------------------------------------------------------------------------------------
#NoEnv
#Include ButtonTextColor.ahk
Gui, Margin, 50, 20
Gui, Font, Bold, Arial

Gui, Add, Button, w200, Common Button

Gui, Add, Button, vBT1 w200 hwndHBTN1, Green Button
If !SetBtnTxtColor(HBTN1, "Green")
   MsgBox, %ErrorLevel%

Gui, Add, Button, vBT2 w200 Default hwndHBTN2, Blue Button
If !SetBtnTxtColor(HBTN2, "Blue")
   MsgBox, %ErrorLevel%

Gui, Add, Button, vBT3 w200 hwndHBTN3, Red Button
SetBtnTxtcolor(HBTN3, "White")

GuiControl, Focus, BT2
Gui, Show, , Colored Button Text
Return
GuiClose:
ExitApp