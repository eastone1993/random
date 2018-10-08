;---------------------CUSTOM HOTKEYS LIBRARY-------------------------------

#SingleInstance, force 
#NoTrayIcon
;submits entered stuff
DetectHiddenWindows, On  
;-------------------------EDITOR---------------------------------------
;creates a hotkey for entered phrase



CreateHotkey(ByRef script_path, ByRef phrase, ByRef message) {	
	path := script_path
	text_field := Trim(phrase) 
	string_edit := message 

	prefix := "::" . text_field 
	;appends _rem to the end of hotkey being overwritten
	suffix :=  prefix . "_rem"
	;ensures no hotkeys with whitespace or empty keys are made 
	if text_field is space
	{
		MsgBox, Please enter a phrase!
		Exit 
	}

	;checks to see if _rem is in custom hotkey 
	if InStr(text_field, "_rem")
	{
		MsgBox, Do not include "_rem" in your hotkey!
		Exit 
	}

	; checks to see if hotkey already exists 
	Loop, read, %path% 
	{
		If InStr(A_LoopreadLine, prefix) ;checks each line of file for string
		{
			If InStr(A_LoopreadLine, suffix)
			{
				MsgBox Found it
				continue 
			}
			else
			{
				Goto, OVERWRITE    ;jump to overwrite function 
			}
			
		}
		
	}

	;creates new autohotkey 
	FileAppend, `n::%text_field%::`n, %path%
	FileAppend,(`n%string_edit%`n)`n`n, %path%

	MsgBox, New Hotkey Added ;confirmation

	;resets custom hotkey file 
	IfWinExist, %path% 
	{
		WinClose, %path% ahk_class AutoHotkey 
		Run, %path%		
	}

	return 

	;goto overwrite: function that asks if they want to overwrite prefixvious hotkey 
	OVERWRITE:
	MsgBox, 4, , HotKey already exists! Would you like to replace it?
	IfMsgBox, Yes  
	{
		;replaces old autohotkey with new one
		FileRead, TheText, %path% 
		StringReplace, NewText, TheText, %prefix%, %suffix%, All

		;rewrites file	   
		FileDelete, %path% 
		FileAppend, %NewText%, %path% 

		;adds new autohotkey to file
		FileAppend,`n::%text_field%::`n, %path%
		FileAppend,(`n%string_edit%`n)`n`n, %path%

		MsgBox, New Hotkey Added ;confirmation

		;resets custom autohotkey file
		IfWinExist, %path% 
		{
			WinClose, %path% ahk_class AutoHotkey 
			Run, %path%		
		}

		return   	 
	}

	IfMsgBox, No 
	{
		Exit 
	}
	
	return 
}

DeleteHotkey(ByRef script_path, ByRef phrase) {

	path := script_path
	text_field := phrase 
	string_edit := message 
	prefix := "::" . text_field 
	;appends _rem to the end of hotkey being overwritten
	suffix :=  prefix . "_rem"
	;ensures no hotkeys with whitespace or empty keys are made 
	if text_field is space
	{
		MsgBox, Please enter a phrase!
		Exit 
	}

	;checks to see if _rem is in custom hotkey 
	if InStr(text_field, "_rem")
	{
		MsgBox, Do not include "_rem" in your hotkey!
		Exit 
	}
	
	Loop, read, %path% 
	{
		If InStr(A_LoopreadLine, prefix) ;checks each line of file for string
		{
			Goto, REMOVE    ;jump to overwrite function 
		}
		
	}

	MsgBox, Hotstring not found!
	Exit 
	;replaces old autohotkey with new one
	REMOVE:
	MsgBox, 4, , Remove %text_field% ?
	IfMsgBox, Yes
	{
		FileRead, TheText, %path% 
		StringReplace, NewText, TheText, %prefix%, %suffix%, All

		;rewrites file	   
		FileDelete, %path% 
		FileAppend, %NewText%, %path% 	

		MsgBox, HotString %text_field% removed.  ;confirmation

		;resets custom autohotkey file
		IfWinExist, %path% 
		{
			WinClose, %path% ahk_class AutoHotkey 
			Run, %path%		
		}

		return 
	}
	IfMsgBox, No 
	{
		MsgBox, Hotstring not removed!
		Exit 
	} 

	return 
}
;-------------------------VIEWER---------------------------------------

CustomHotkeyViewer(ByRef script_path) {
	path := script_path 

	colon := "::"
	par1 := "("
	par2 := ")"
	star := "*"

	FileRead, FileContents, %path% 
	;MsgBox % FileContents
	StringReplace, RepColon, FileContents, %colon%, %star%, All
	StringReplace, RepPar, RepColon, %par1%, , All 
	StringReplace, NewContents, RepPar, %par2%, , All  

	;MsgBox % NewContents
	Loop, Parse, NewContents, `n
	{
		If InStr(A_LoopField, "END_OF_HEADER")
		{
			end_of_header := A_Index
			;MsgBox %end_of_header% : %A_LoopField%
			break
		}
		else 
		{
			continue 
		}
	}

	trash := false ;false when adding the line to custom view output
	
	Loop, Parse, NewContents, `n`n`n 
	{
		if (A_Index <= end_of_header)
		{
			;MsgBox %A_Index% : %end_of_header% : %A_LoopField%
			continue 
		}
		else if InStr(A_LoopField, "_rem") ;changes a to true when _rem is found 
		{
			trash := true 
			;MsgBox, %A_LoopField% NOT ADDED 
			continue ;exits loop without adding to custom view 
		} 
		else if (trash = true) ;once _rem is found, continue ignoring elements associated with _rem 
		{
			if InStr(A_LoopField, "*") ;new hotstring no longer associated with _rem, 
			{
				trash := false ;addable element 
				;MsgBox, %A_LoopField% ADDED 
				AddToViewer(A_LoopField) ;deciedes if it should add 
				continue 
			}
			else ;if true but no new element, must still be part of _rem 
			{
				;MsgBox, %A_LoopField% NOT ADDED 
				Continue ;restart loop without adding to custom view 
			}
		}
		else 
		{
			AddToViewer(A_LoopField) ;if false and not _rem, it must be addable to custom view 
			;MsgBox, %A_LoopField% ADD 
			continue 
		}
	}

	FileRead, CusView, %A_ScriptDir%\cus.txt  
	;GuiControl,, CustomRef, %CusView%
	FileDelete, %A_ScriptDir%\cus.txt
	;MsgBox % CusView 
	return CusView 
}


AddToViewer(arg) { ;decides if argument should be added to custom view output
	;MsgBox % arg 
	if (arg = "`n") ;does not add extra whitespace
	{
		;MsgBox arg executed 
		Exit ;do not do anything else if whitespace
	}
	else 
	{
		FileAppend, `n%arg% , %A_ScriptDir%\cus.txt ;add to custom view 
	} 
}


ViewerSettings(Byref setting, Byref viewVal) { ;user specified setting determines what is displayed by viewer
	if(setting = 0)
	{
		return viewVal ;viewVal has both phrase and message 
	}
	if(setting = 1)
	{
		return ViewPhraseOnly(viewVal) ;returns the phrase only view 
	}
	else
	{ 
		return viewVal ;viewVal is default view if nothing else is specified 
	}
}

ViewPhraseOnly(Byref viewVal) { ;returns only the phrase 
	viewText := viewVal
	viewArray :=[]
	Loop, Parse, viewText, *   ;parses by the asterik delimiter to separate phrases from their messages
	if InStr(A_LoopField, "`n") ;when parsed, only messages contain the newline character
	{
		continue ;if a newline character is found in loopfield, skip that loopfield 
	}
	else 
	{
		viewArray.push(A_LoopField) ;pushes the phrase to the array 
		continue 
	}
	return Join("`n`n", viewArray) ;returns the array of phrases separated by newline characters for easier viewing
}

Join(s,p*) {
  static _:="".base.Join:=Func("Join")
  for k,v in p
  {
    if isobject(v)
      for k2, v2 in v
        o.=s v2
    else
      o.=s v
  }
  return SubStr(o,StrLen(s)+1)
}