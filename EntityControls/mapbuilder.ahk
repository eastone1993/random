#SingleInstance, force 
#Persistent
#Include ButtonTextColor.ahk
CoordMode, Mouse, Client 
;----------------------------------- GLOBAL VARS -------------------------------------------------------------------------------------------------------------
global arr := Object()
global map_rows
global map_columns
EnvGet, msetting, MAPSETTING
;----------------------------------- FIND SETTINGS -------------------------------------------------------------------------------------------------------------

if (msetting = 1)				;open existing MAP file
{
	IniRead, map_size, settings.ini, mapbuildersettings, size 
	IniRead, map_fontsize, settings.ini, mapbuildersettings, fontsize
	map_font := " s" . map_fontsize
	Gui, Font, %map_font%, Arial
	EnvGet, mapfpath, MAPFILEPATH 
	OpenButtonGrid(map_size,mapfpath) 
}	
Else                            ;open new MAP file
{
	IniRead, map_fontsize, settings.ini, mapbuildersettings, fontsize 
	IniRead, map_rows, settings.ini, mapbuildersettings, rows
	IniRead, map_columns, settings.ini, mapbuildersettings, columns
	IniRead, map_size, settings.ini, mapbuildersettings, size 
	map_font := " s" . map_fontsize
	Gui, Font, %map_font%, Arial
	BuildNewButtonGrid(map_size,map_rows,map_columns)
}

;map builder 
map_blocknumber := map_rows * map_columns
global map_dimensions := " w" . map_size * map_columns . " h" . map_size * map_rows 

;----------------------------------- CONSTRUCTORS -------------------------------------------------------------------------------------------------------------

;menu constuctors
Menu, FILEdd, Add, New, NewL
Menu, FILEdd, Add, Open, OpenL
Menu, FILEdd, Add, SaveAs, SaveAsL
Menu, FILEdd, Add, Exit, ExitL

Menu, MyMenuBar, Add, File, :FILEdd
Menu, MyMenuBar, Add, Settings, SettingsL

;gui constuctors 
Gui, Menu, MyMenuBar 
Gui, Show, %map_dimensions%, Map Builder

WinGet, MapBuilderWin,, Map Builder 

return 
 
;----------------------------------- MENU LABELS -------------------------------------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------- FILE -------------------------------------------------------------------------------------------------------------
NewL:
{
	MsgBox, 3,, Do you wish to Save before opening a new file?
	IfMsgBox Yes 
	{
		SaveAs(map_blocknumber, map_columns)
		EnvSet, MAPSETTING, 0
		Reload
	}
	IfMsgBox No 
	{
		EnvSet, MAPSETTING, 0
		Reload
	} 
	return  
}
OpenL:
{
	MsgBox, 3,, Do you wish to Save before opening a new file?
	IfMsgBox Yes 
	{
		SaveAs(map_blocknumber, map_columns)
		openfile := OpenFile()
		EnvSet, MAPSETTING, 1
		EnvSet, MAPFILEPATH, %openfile%
		Reload
	}
	IfMsgBox No
	{
		openfile := OpenFile() 
		EnvSet, MAPSETTING, 1
		EnvSet, MAPFILEPATH, %openfile%
		Reload 
	} 	
	return
}
SaveAsL:
{
	SaveAs(map_blocknumber, map_columns)
	return 
}
ExitL:
{
	MsgBox, 3,, Do you wish to Save before exiting?
	IfMsgBox Yes 
	{
		SaveAs(map_blocknumber, map_columns)
		ExitApp
	}
	IfMsgBox No 
	{
		ExitApp 
	}
	return 
}
;----------------------------------- SETTINGS -------------------------------------------------------------------------------------------------------------
SettingsL:
{
	if WinExist("Map Builder Settings")
	{
		WinActivate, Map Builder Settings
		return 
	}
	;rows and columns of blocks 
	Gui 2: Add, Text, x10 y10, Number of Rows: 
	Gui 2: Add, Edit, x110 y10 vRowSetting, %map_rows%
	Gui 2: Add, Text, x10 y40, Number of Columns: 
	Gui 2: Add, Edit, x110 y40 vColumnSetting, %map_columns% 
	
	;size of blocks 
	Gui 2: Add, Text, x10 y80, Size of Blocks: 
	Gui 2: Add, Edit, x110 y80 
	Gui 2: Add, UpDown, vSizeSetting Range25-500, %map_size%

	;font setting 
	Gui 2: Add, Text, x10 y120, Font Size 
	Gui 2: Add, Edit, x110 y120,
	Gui 2: Add, UpDown, vFontSetting Range10-60, %map_fontsize%
	;submit button 
	Gui 2: Add, Button, x75 y155 w100 h20 vSettingsSubmit gSUBMIT_SETTINGS, Submit

	Gui 2: Show, w250 h200, Map Builder Settings 

	return 
}
;----------------------------------- GUI CONTROLS -------------------------------------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------- MAIN GUI CONTROLS -------------------------------------------------------------------------------------------------------------
GuiClose:
ExitApp 

Esc::
ExitApp 
return 

;----------------------------------- SETTINGS GUI CONTROLS -------------------------------------------------------------------------------------------------------------
2GuiClose:
Gui 2: Destroy 
return 

SUBMIT_SETTINGS:
{
	Gui 2: Submit 
	if (RowSetting*SizeSetting > 1100) or (ColumnSetting*SizeSetting > 2000)
	{
		MsgBox, Size of window is too large! 
		Gui 2: Destroy
		Exit 
	}
	IniWrite, %FontSetting%, settings.ini, mapbuildersettings, fontsize
	IniWrite, %RowSetting%, settings.ini, mapbuildersettings, rows 
	IniWrite, %ColumnSetting%, settings.ini, mapbuildersettings, columns 
	IniWrite, %SizeSetting%, settings.ini, mapbuildersettings, size 
	Gui 2: Destroy
	Reload 
	return
}
 
;----------------------------------- MouseButttonActions -------------------------------------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------- LEFT MOUSE BUTTON -------------------------------------------------------------------------------------------------------------
~LButton::
{
	LeftButtonStart:
	MouseGetPos, UnderX, UnderY, WinUnderHwnd, ControlUnder
	if(WinUnderHwnd = MapBuilderWin) and (UnderY > 0)
	{
		if (lCU != ControlUnder)
			arr[ControlUnder] := arr[ControlUnder]+1		;block data is stored in arr and must be retrieved
		if arr[ControlUnder] > 9
			arr[ControlUnder] := 0
		content := arr[ControlUnder]
		ControlSetText, %ControlUnder%, %content%, Map Builder  ;set new block data	
		ChangeColor(ControlUnder, content)
		lCU := ControlUnder
		KeyState := GetKeyState("LButton")
		if (KeyState = 1)
			Goto, LeftButtonStart 
	}
	return
}

;----------------------------------- RIGHT MOUSE BUTTON -------------------------------------------------------------------------------------------------------------
~RButton::
{
	RightButtonStart:
	MouseGetPos, UnderX, UnderY, WinUnderHwnd, ControlUnder 
	if(WinUnderHwnd = MapBuilderWin) and (UnderY > 0)
	{
		if (rCU != ControlUnder)
			arr[ControlUnder] := arr[ControlUnder]-1
		if arr[ControlUnder] < 0
			arr[ControlUnder] := 9
		content := arr[ControlUnder]
		ControlSetText, %ControlUnder%, %content%, Map Builder  	
		ChangeColor(ControlUnder, content)
		rCU := ControlUnder 
		KeyState := GetKeyState("RButton")
		if (KeyState = 1)
			Goto, RightButtonStart
	}
	return 
}
;----------------------------------- FUNCTIONS -------------------------------------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------- NEW GRID BUILDER -------------------------------------------------------------------------------------------------------------
BuildNewButtonGrid(s, num_rows, num_columns) {
	global 
	local x0, y0, h0, w0, y1 
		
	x0 := 0, y0 := 0, w0 := s, h0 := s, x1 := 0 
	width := " w" . w, height := " h" . h
	ncol := num_columns, nrows := num_rows
	bcount := 0

	Loop %nrows%
	{
		rpos := A_Index
		Loop %ncol%
		{
			local bname 
			cpos := A_Index 
			bcount := bcount+1, btnname := rpos . "_" . cpos, bname := "v" . btnname, BtnCtrl := "Button" . bcount 
			xywh := "x" . x0 . " y" . y0 . " w" . w0 . " h" . h0
			Gui, Add, Button, %xywh% %bname%, 0
			arr[BtnCtrl] := 0
			GuiControlGet, btnHWND, Hwnd, %btnname%
			SetBtnTxtColor(btnHWND,"Silver")
			x0 := (x0 + w0)
		}
		y0 := (y0 + h0)
		if(x1 < x0)
			x0 := x1
	}

	return 
}
;----------------------------------- OPEN FILE -------------------------------------------------------------------------------------------------------------
OpenFile() {
	FileSelectFile, openfile, 3, \MapFiles, *.map
	if ErrorLevel
		Exit 
	if !InStr(openfile, ".map")
	{
		MsgBox, Please select file with extension: .map 
		OpenFile()
	}
	return openfile 
}

OpenButtonGrid(s, file) {
	;FileSelectFile, openfile, 3, %A_WorkingDir%\MapFiles, *.map 
	global 
	local x0, y0, h0, w0, y1 
		
	x0 := 0, y0 := 0, w0 := s, h0 := s, x1 := 0 
	width := " w" . w, height := " h" . h
	;column := 0, row := 0 

	Loop, read, %file%
	{
		row := A_Index
		Loop, PARSE, A_LoopReadLine, `,
		{
			local bname
			col := A_Index
			if (A_LoopField="")
				continue
			bname := "v" . row . "_" . col 
			xywh := "x" . x0 . " y" . y0 . " w" . w0 . " h" . h0
			Gui, Add, Button, %xywh% %bname%, %A_LoopField%
			x0 := (x0 + w0)
		}
		y0 := (y0 + h0)
		if(x1 < x0)
			x0 := x1
	}

	map_columns := col-1
	map_rows := row
	;map_dimensions := " w" . map_size * (col-1) . " h" . map_size * row


	return 
}
;----------------------------------- SAVE FUNCTION -------------------------------------------------------------------------------------------------------------
SaveAs(blocknumber, colnumber) {
	FileSelectFile, savefile, S24, \MapFiles, *.map
	if ErrorLevel
		Exit 
	if !InStr(savefile, ".map")
	{
		MsgBox, Please select file with extension: .map 
		SaveAs(blocknumber, colnumber)
	}
	CopyGridToFile(blocknumber, colnumber, savefile)
	return 
}

CopyGridToFile(blocknumber, colnumber, filepath) { 
	num := 1
	colcounter := 0
	;num := blocknumber 
	if FileExist(filepath)
		FileDelete, %filepath%
	while (num <= blocknumber)
	{		
		if (colcounter = colnumber)
		{
			FileAppend, `n, %filepath% 
			colcounter := 0
		}
		blockname := "Button" . num
		ControlGetText, content, %blockname%, Map Builder
		;MsgBox, ControlName: %blockname% `n %content%
		FileAppend, %content%`,, %filepath%
		num := num + 1
		colcounter := colcounter + 1
	}
	return 
}
;----------------------------------- COLOR CHANGE FUNCTIONS -------------------------------------------------------------------------------------------------------------

NumberToColor(num) {
	if num = 0
		return "silver"
	else if num = 1
		return "black"
	else if num = 2
		return "red"
	else if num = 3
		return "white"
	else if num = 4
		return "yellow"
	else if num = 5
		return "blue"
	else if num = 6
		return "green"
	else if num = 7
		return "purple"
	else if num = 8
		return "Maroon"
	else 
		return "gray"
}

ChangeColor(ctrlund, content) {
	btnColor := NumberToColor(content)
	GuiControlGet, btnHWND, Hwnd, %ctrlund%
	SetBtnTxtColor(btnHWND,btnColor)
	return 
}



