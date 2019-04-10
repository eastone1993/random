#SingleInstance, force 
#Persistent 

/*

global arr := [[1,1,1,1,1,1,1,1,1,1]
,[1,0,0,0,0,0,0,0,0,1]
,[1,0,0,0,0,0,0,0,0,1]
,[1,0,0,0,1,0,0,0,0,1]
,[1,0,0,1,1,0,0,0,0,1]
,[1,0,0,1,1,0,0,0,0,1]
,[1,0,0,0,1,1,0,0,0,1]
,[1,0,0,0,0,0,0,0,0,1]
,[1,1,1,0,0,0,0,0,0,1]
,[1,1,1,1,1,1,1,1,1,1]]
*/
mapfile := A_WorkingDir . "\Map Files\maze.map"

global arr := []

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

MsgBox % arr[2][2]

p1 := new player("evan", 100, 100, "up", arr)
coordinates := p1.getxy()
image := p1.getplayerimage()
dimensions := p1.getdimensions()
playername := p1.getplayerimagename()
Gui, Add, Picture, %coordinates% %dimensions% %playername%, % image 

;draws blocks for player to navigate through
for index, array in arr 
{
	arr_y := A_Index 
	
	for index, elem in array 
	{
		arr_x := A_Index
		if (arr[arr_y][arr_x]=1)
		{
			arr_y0 := (arr_y-1)*100, pic_y := " y" . arr_y0
			arr_x0 := (arr_x-1)*100, pic_x := " x" . arr_x0
			Gui, Add, Picture, %pic_x% %pic_y% w100 h100, block.png
		}

	}
}

Gui, Show, w1000 h1000 , entity p1ing

return 


Esc::
ExitApp 

GuiClose: 
ExitApp

up::
{
	p1.moveplayer("up")
	return 
}

down::
{
	p1.moveplayer("down")
	return
}

right::
{
	p1.moveplayer("right")
	return
}

left::
{
	p1.moveplayer("left")
	return
}
;----------------------------------- PLAYER CLASS -------------------------------------------------------------------------------------------------------------
class player 
{
	playername :=
	playerimagename :=
	xPos := 
	yPos := 
	direction :=
	dimensions := "w100 h100"
	playerimage := A_ScriptDir . "\player.png" 
	__New(n, x, y, d, a) {
		this.playername := n
		this.playerimagename := "v" . n
		this.xPos := x
		this.yPos := y 
		this.direction := d 
		this.coordinates := this.getxy() 
	} 


;get methods
	getplayerimagename() {
		return this.playerimagename
	}
	getxpos() {
		return this.xpos 
	}

	getypos() {
		return this.ypos
	}
	getxy() {
		xy := " x" . this.xpos . " y" . this.ypos 
		return xy 
	}
	getdirection() {
		return this.direction
	}
	getplayerimage() {
		return this.playerimage 
	}
	getdimensions() {
		return this.dimensions
	}


;set methods 
	setxpos(x) {
		this.xpos := x
	}
	setypos(y) {
		this.ypos := y
	}
	setplayerimage(img){
		this.playerimage := img
	}

	setdirection(d) {
		if (d != "up") or (d != "down") or (d != "left") or (d != "right")
		{
			MsgBox, Error: invalid direction for player object. 
			Exit
		}
		this.direction := d
	}

;check array method 
	checkarray(d) { ;we use floor so that we do not pass a decimal number to the array
		;global arr 
		if d = up
		{ 
			gridy := Floor((this.ypos - 100)/100) + 1
			gridx := Floor(this.xpos/100) + 1
			return arr[gridy][gridx]  
			;MsgBox y:%gridy% x:%gridx%
		}
		else if d = down
		{
			gridy := Floor((this.ypos + 100)/100) + 1
			gridx := Floor(this.xpos/100) + 1
			return arr[gridy][gridx] 
		}
		else if d = right
		{
			gridy := Floor(this.ypos/100) + 1
			gridx := Floor((this.xpos+100)/100) + 1
			return arr[gridy][gridx]  
			;MsgBox y:%gridy% x:%gridx%
		}
		else if d = left
		{
			gridy := Floor(this.ypos/100) + 1
			gridx := Floor((this.xpos-100)/100) + 1
			return arr[gridy][gridx]  
			;MsgBox y:%gridy% x:%gridx%
		}
		return 
	}
;movement methods 

	moveplayer(d) {
		;global arr 
		if d = up
		{
			upBound := this.ypos 
			;MsgBox % upBound
			if (upBound = 0) 
				return  
			if (this.checkarray("up")=1)
				return
			Loop, 10
			{	
				;MsgBox, moved up
				newy := this.ypos - 10
				this.ypos := newy
				xy := this.getxy()
				playername := this.playername 
				GuiControl, Move, %playername%, %xy% %dimensions%
				sleep 40
				;MsgBox,  , %xy%, %dimensions%
			}
			return 
		}
		else if d = down 
		{
			downBound := this.ypos 
			if (downBound = 900)
				return 
			if (this.checkarray("down")=1)
				return 
			Loop, 10
			{	
				;MsgBox, moved up
				newy := this.ypos + 10
				this.ypos := newy
				xy := this.getxy()
				playername := this.playername 
				GuiControl, Move, %playername%, %xy% %dimensions%
				;MsgBox,  , %xy%, %dimensions%
				sleep 40
			}
			return 
		}
		else if d = left
		{
			leftBound := this.xpos 
			if (leftBound = 0)
				return 
			if (this.checkarray("left")=1)
				return
			Loop, 10
			{
				;MsgBox, moved up
				newx := this.xpos - 10
				this.xpos := newx
				xy := this.getxy()
				playername := this.playername 
				GuiControl, Move, %playername%, %xy% %dimensions%
				;MsgBox,  , %xy%, %dimensions%
				sleep 40
			}
			return
		}
		else if d = right
		{
			rightBound := this.xpos 
			if (rightBound = 900)
				return 
			if (this.checkarray("right")=1)
				return
			Loop, 10 
			{	
				;MsgBox, moved up
				newx := this.xpos + 10
				this.xpos := newx
				xy := this.getxy()
				playername := this.playername 
				GuiControl, Move, %playername%, %xy% %dimensions%
				;MsgBox,  , %xy%, %dimensions%
				sleep 40
			}
			return
		}

		else 
		{
			MsgBox, Error: Direction: %d% is an invalid direction for player object. 
			Exit 
		}
	}

}

