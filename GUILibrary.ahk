;----------------------------------- LIBRARY FOR GUI BUILDING AND USAGE -------------------------------------------------------------------------------------------------------------
#SingleInstance, force 
#NoTrayIcon

wx := 0
hx := 0

BuildTap(ByRef buttonName, ByRef buttonText, ByRef x:=50, ByRef y:=0, ByRef w:=200, ByRef h:=30)
{
	global ;gui controls must use global or static variables

	;variables must be state for params, and must be local 
	local OnButton0, OffButton0, OnButton, OnFunction, OnText, x0, y0, w0, h0, xywh, OffButton, OffFunction, OffText 
	
	;state params below
	x0 := "x" . x 
	y0 := " y" . y
	w0 := " w" . w 
	h0 := " h" . h 
	xywh := x0 . y0 . w0 . h0 

	
	;button variable names MUST be preceded by v 
	OnButton := "v" . buttonName . "On"
	OnButton0 := buttonName . "On"

	OnFunction := "g" . buttonName . "On"	
	OnText := buttonText

	Gui, Add, Button, %xywh% %OnButton% %OnFunction%, %OnText%

	return 
}


BuildButton(ByRef buttonName, ByRef buttonText, ByRef x:=50, ByRef y:=0, ByRef w:=200, ByRef h:=30)
{
	global ;gui controls must use global or static variables

	;variables must be state for params, and must be local 
	local OnButton, OnFunction, OnText, x0, y0, w0, h0, xywh, OffButton, OffFunction, OffText 
	
	;state params below
	x0 := "x" . x 
	y0 := " y" . y
	w0 := " w" . w 
	h0 := " h" . h 
	xywh := x0 . y0 . w0 . h0  
	
	;button variable names MUST be preceded by v 
	OnButton := "v" . buttonName . "On"
	OffButton := "v" . buttonName . "Off"

	;button function names MUST be preceded by g 
	OnFunction := "g" . buttonName . "On"	
	OnText := "Run " . buttonText
	OffFunction := "g" . buttonName . "Off"
	OffText := "End " . buttonText

	;builds on and off button 
	Gui, Add, Button, %xywh% %OnButton% %OnFunction%, %OnText%
	Gui, Add, Button, %xywh% Hidden %OffButton% %OffFunction%, %OffText%
	
	;MsgBox, %OffButton%

	return    
}


OnButton(ByRef buttonName, ByRef dr="", ByRef ext=".ahk")
{
	global ;gui controls must use global or static variables

	;variables must be state for params, and must be local 
	local OnButton, OffButton, dir, file1  

	;state params below
	dir := A_WorkingDir . dr . "\" . buttonName . ext ;A_WorkingDir is built in variable that refers to current directory working in 
	OnButton := buttonName . "On"
	OffButton := buttonName . "Off"

	Run, %dir% 
	;MsgBox, "Got into dirp"
	GuiControl, Hide, %OnButton%
	GuiControl, Show, %OffButton%

	;listener that turns button back on if window doesn't exist 
	 
	file1 := buttonName . ".ahk"
	sleep 250
	WinWaitClose, %file1% 
	{
		;MsgBox, "I got into WinWaitClose"
		GuiControl, Hide, %OffButton%
		GuiControl, Show, %OnButton%

		return 
	}
	
	

	return 
}

Tap(ByRef buttonName, ByRef dr="", ByRef ext=".ahk")
{
	global ;gui controls must use global or static variables

	;variables must be state for params, and must be local 
	local dir

	;state params below
	DetectHiddenWindows, On 
	dir := A_WorkingDir . dr . "\" . buttonName . ext ;A_WorkingDir is built in variable that refers to current directory working in 
	WinClose, %dir% ahk_class AutoHotkey 
	Run, %dir% 

	return 
}

OffButton(ByRef buttonName, ByRef dr="", ByRef ext=".ahk")
{
	global 
	local OnButton, OffButton, dir 

	dir := A_WorkingDir . dr . "\" . buttonName . ext 
	OnButton := buttonName . "On"
	OffButton := buttonName . "Off" 

	GuiControl, Hide, %OffButton%
	GuiControl, Show, %OnButton%

	DetectHiddenWindows, On 
	WinClose, %dir% ahk_class AutoHotkey

	return 
}

ExitAll(params*)
{	
	global 
	DetectHiddenWindows, On 
	for index, file in params 
	{
		local dir  
		dir := A_WorkingDir . "\" . file 
		WinClose, %dir% ahk_class AutoHotkey 
	}
	return 
}

ExitAllArray(ByRef dr="", ByRef ext=".ahk", params*) ; first parameter is the extension, second is an array of file names without extension
{
	
	global 
	DetectHiddenWindows, On
	extension := ext  
	for index, array in params 
	{
		;MsgBox, %array%
		for index, name in array 
		{
		local dir
		dir := A_WorkingDir . dr . "\" . name . ext 
		WinClose, %dir% ahk_class AutoHotkey
		;MsgBox, EXIT %dir%
		 
		}
	}
	return 
}

BuildButtonArray(ByRef x, ByRef y, ByRef w, ByRef h, ByRef s, params0*)
{
	global 
	local x0, y0, h0, w0, s0 
		
	x0 := x ;x variable for button 
	y0 := y ;starting y variable
	w0 := w ;width of buttons 
	h0 := h ;height of buttons 
	s0 := s ;space between buttons
	y1 := y 
	s1 := x

	BAheight := 0

	for index, array0 in params0 
	{
		for index, file in array0 
		{
			local dir0 
			dir0 := file 
			BuildButton(dir0, dir0, x0, y0, w0, h0)
			y0 := (y0 + s0 + h0)
		}

		x0 := (x0 + s0 + w0)
		if (y1 < y0)
		{
			if (y0 > BAheight)
			{
				BAheight := y0
			}

			y0 := y1  
		}
	}

	BAwidth := x0
	return

}

HideButtonArray(offparams*)
{
	global
	local OffButton 
	for param in offparams
	{
		OffButton := buttonName . "Off"
		GuiControl, Hide, %OffButton%
	}
	return 
}

BuildTapArray(ByRef x, Byref y, ByRef w, ByRef h, ByRef s, params1*)
{
	global 
	local x0, y0, h0, w0, s0, y1 
		
	x0 := x ;x variable for button 
	y0 := y ;starting y variable
	w0 := w ;width of buttons 
	h0 := h ;height of buttons 
	s0 := s ;space between buttons
	y1 := y 
	s1 := x

	TAheight := 0

	for index, array1 in params1 
	{
		for index, file in array1 
		{
			local dir1 
			dir1 := file 
			BuildTap(dir1, dir1, x0, y0, w0, h0)
			y0 := (y0 + s0 + h0)
		}

		x0 := (x0 + s0 + w0)
		if (y1 < y0)
		{
			if(y0 > TAheight)
			{
				TAheight := y0
			}
			
			y0 := y1  
		}
	}

	TAwidth := x0
	return

}

BuildGui(ByRef GuiName, ByRef x, ByRef y)
{
	global 
	local xt, yt, ht, wt, gname 


	if(TAheight < BAheight)
	{
		height := BAheight
	}

	else 
	{
		height := TAheight
	}

	if(TAwidth < BAwidth)
	{
		width := BAwidth
	} 

	else 
	{
		width := TAwidth
	}

	width := width + wx 
	height := height + hx
	
 

	gname := GuiName
	ht := " h" . height 
	wt := " w" . width 
	xt := " x" . x
	yt := " y" . y
	Gui, Show, %xt% %yt% %ht% %wt%, %gname%

	return 
}

AddGuiDimension(ByRef wid, ByRef het)
{
	global 
	wx := wx + wid 
	hx := hx + het 

	return 
}

/*
#Persistent
#SingleInstance, force 
;#NoTrayIcon
;#Include %A_Desktop%\anchor.ahk 
Gui, +Resize
Gui, Show, w1250 h756, E-mail Template Reference Sheet 

WinGetPos, , , GuiWidth, GuiHeight, E-mail Template Reference Sheet 

GW := " w" . GuiWidth
GH := " h" . GuiHeight
Gui, Add, Picture, x0 y0 %GW% %GH%, %A_WorkingDir%\images\ref.png
;MsgBox % GW 
;MsgBox % GH 
return 

GuiSize:
WinGetPos, , , GuiWidth, GuiHeight, E-mail Template Reference Sheet 
GW := " w" . GuiWidth
GH := " h" . GuiHeight
Gui, Add, Picture, x0 y0 %GW% %GH%, %A_WorkingDir%\images\ref.png
Gui, Show, %GW% %GH%, E-mail Template Reference Sheet 
return 

GuiClose:
ExitApp
*/