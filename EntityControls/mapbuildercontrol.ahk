#SingleInstance, force 
#Persistent 

mapfile := A_WorkingDir . "\Map Files\maze.map"

global arr := {"derp":2,"herp":3}
;arr[1] := []
;arr[1][1] := 2 
;MsgBox % arr[1][1]

hahaha := weirdfunc()

MsgBox % arr[hahaha]

/*
Loop, Read, %mapfile%
{
	row := A_Index 
	arr[row] := []
	Loop, Parse, A_LoopReadLine, `,
	{
		if (A_LoopField="")
			continue 
		arr[row][A_Index] := A_LoopField
		;MsgBox % A_LoopField 
	}
}
*/
;MsgBox % arr[1][1]

weirdfunc() {
	return "herp"
}

ESC::
ExitApp 

return 