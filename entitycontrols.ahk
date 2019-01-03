#SingleInstance, force 
#Persistent

arr := [["","","",""],["","","",""],["","","",""],["","","",""]]

;Gui, Add, Edit, x0 y0 w100 h100 ReadOnly -VScroll -HScroll vROW1, %r1%

;DrawArea(0,0,100,100,arr)

;Gui, Add, GroupBox, x100 y100 w100 h100
;Gui, Add, Text, HERP DERP
test := new player("evan", 50, 50, "up")
coordinates := test.getxy()
image := test.getplayerimage()
dimensions := test.getdimensions()
playername := test.getplayerimagename()
;MsgBox % image 
;test.getXPos() 
;MsgBox % test1

Gui, Add, Picture, %coordinates% %dimensions% %playername%, % image 

Gui, Show, w1000 h1000 , entity testing 

return 

GuiClose: 
ExitApp

up::
{
	test.moveplayer("up")
	return 
}

down::
{
	test.moveplayer("down")
	return
}

right::
{
	test.moveplayer("right")
	return
}

left::
{
	test.moveplayer("left")
	return
}

class player 
{
	playername :=
	playerimagename :=
	xPos := 
	yPos := 
	direction :=
	dimensions := "w50 h50"
	playerimage := A_Desktop . "\player.png"

	__New(n, x, y, d) {
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

;movement methods 

	moveplayer(d) {
		if d = up
		{
			;MsgBox, moved up
			newy := this.ypos - 10
			this.ypos := newy
			xy := this.getxy()
			playername := this.playername 
			GuiControl, Move, %playername%, %xy% %dimensions%
			;MsgBox,  , %xy%, %dimensions%
			return 
		}
		else if d = down 
		{
			;MsgBox, moved up
			newy := this.ypos + 10
			this.ypos := newy
			xy := this.getxy()
			playername := this.playername 
			GuiControl, Move, %playername%, %xy% %dimensions%
			;MsgBox,  , %xy%, %dimensions%
			return 
		}
		else if d = left
		{
						;MsgBox, moved up
			newx := this.xpos - 10
			this.xpos := newx
			xy := this.getxy()
			playername := this.playername 
			GuiControl, Move, %playername%, %xy% %dimensions%
			;MsgBox,  , %xy%, %dimensions%
			return
		}
		else if d = right
		{
			;MsgBox, moved up
			newx := this.xpos + 10
			this.xpos := newx
			xy := this.getxy()
			playername := this.playername 
			GuiControl, Move, %playername%, %xy% %dimensions%
			;MsgBox,  , %xy%, %dimensions%
			return
		}

		else 
		{
			MsgBox, Error: Direction: %d% is an invalid direction for player object. 
			Exit 
		}
	}

}







 
DrawArea(ByRef x, ByRef y, ByRef w, ByRef h, byref param) {
	global 
	local x0, y0, h0, w0, xywh 

	x0 := x 
	y0 := y
	w0 := w 
	h0 := h  ;height of buttons 

	for index, array in param 
	{
		row := "r" . A_Index 

		for index, val in array 
		{ 
			vCoord := "v" . row . "c" . A_Index  
			;MsgBox % vCoord 
			xywh := " x" . x0 " y" . y0 " w" . w0 " h" . h0
			;MsgBox % xywh 
			;Gui, Add, Edit, %xywh% ReadOnly -VScroll -HScroll %vCoord%, % val 	
			Gui, Add, GroupBox, %xywh% Section
			Gui, Add, Text, xs+50 ys+50, % vCoord
			x0 := (x0 + w0)
		}

		x0 := 0
		y0 := (y0 + h0)

	}

	return 
}






/*
DrawObj(params*) {
	for val in params 
	{
		if val = 1
		{

		}
	}
}
*/
