#SingleInstance, force  
#persistent 

getIndex := ;empty var declared for column number

FileSelectFile, inputfile, 3, %A_Desktop%,, Microsoft Excel Comma Separated Values File (*.csv) ;opens window to select directory
sleep 50 

SplitPath, inputfile,,,, OutNameNoExt ;finds singluar name of file
folder := OutNameNoExt . " Split Files Folder" ;creates var folder based on file name 

If(inputfile = "") ;if user cancels file exits 
	ExitApp 

InputBox, splitparam, Column Header Input, Enter in the column header to split the file by. ;enter column header param to parse file by

Loop, Parse, inputfile, . ;loops once to remove the file extension
{
	filename := A_LoopField
	break 
} 

foldername := filename . " Split Files Folder" ;foldername is file name without extension plus
FileCreateDir, %foldername% ;creates directory for that folder 

FileReadLine, header, %inputfile%, 1 ;find the column headers of the file 
sleep 50

Loop, Parse, header,`, ;searching through header to get val for var getIndex 
{
	if instr(A_LoopField, splitparam)
	{
		getIndex := A_Index 
		;MsgBox % A_Index 
		Goto, SCHOOLFOUND ;school found jump pas next step 
	}
}

MsgBox, %splitparam% column header not found!
ExitApp


;MsgBox % getIndex 

SCHOOLFOUND:
Loop, Read, %inputfile% ;goes through main file 
{
	parseline := A_LoopReadLine
	if (A_LoopReadLine = header)
		continue 
	;MsgBox % A_LoopReadLine 
	Loop, Parse, parseline,`,
	{
		;MsgBox, School Index: %getIndex% CurrentInd: %A_Index% 
		if (A_Index = getIndex)
		{
			;MsgBox, index match!
			;MsgBox % A_LoopField 
			schoolname := A_LoopField 
			schoolfilename := foldername . "\" . schoolname . ".csv"	
			if !FileExist(schoolfilename) ;checks to see if file already exists 
				FileAppend, %header%`n, %schoolfilename% ;if file doesn't already exist, adds header 
			FileAppend, %A_LoopReadLine%`n, %schoolfilename%
			break 	;break parsing loop and move onto next file read line			 
		}
	}
}

destdir := A_Desktop . "\" . folder
FileMoveDir, %foldername%, %destdir% ;move directory to desktop 

MsgBox, Process completed! ;process complete notification

Run, explore %destdir% ;open windows explorer to new file location 

ExitApp 

return 

Esc:: ;button to end process if needed 
MsgBox, Process canceled!
ExitApp



