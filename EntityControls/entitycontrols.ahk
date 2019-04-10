#SingleInstance, force 
#Persistent

arr := [[0,0,0,0],[0,0,0,0],[0,0,1,0],[0,0,0,0]]
;derp := arr[3][3]
;MsgBox % derp 
;player contruction block 
p1 := new player("evan", 0, 0, "up", arr)
coordinates := p1.getxy()
image := p1.getplayerimage()
dimensions := p1.getdimensions()
playername := p1.getplayerimagename()
Gui, Add, Picture, %coordinates% %dimensions% %playername%, % image 

;environment contruction block 
b1 := new block("block1", 200, 200)
coordinates0 := b1.getxy()
image0 := b1.getblockimage()
dimensions0 := b1.getdimensions()
blockname0 := b1.getblockimagename()
Gui, Add, Picture, %coordinates0% %dimensions0% %playername0%, % image0 

Gui, Show, w400 h400 , entity p1ing 

;test()

return 

test() {
	global arr 
	MsgBox % arr[3][3]
	return 
}

Esc::
ExitApp 

GuiClose: 
ExitApp

up::
{
	p1.moveplayer(arr,"up")
	return 
}

down::
{
	p1.moveplayer(arr,"down")
	return
}

right::
{
	p1.moveplayer(arr,"right")
	return
}

left::
{
	p1.moveplayer(arr,"left")
	return
}

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


	checkarray(d) {
		;MsgBox, execute
		;a := this.arrayname 
		if(d = up)
		{
			;MsgBox, up 
			gridy := Floor((this.ypos - 100)/100)
			gridx := Floor(this.xpos/100)
			gridxy := a[gridx][gridy]  
			;MsgBox y:%gridy% x:%gridx%
			;MsgBox % gridxy 
			if (gridxy = 1)
			{
				;MsgBox, Derp!
				;Exit 
			}
		}
		return 
	}
;movement methods 

	moveplayer(a,d) {
		if d = up
		{
			upBound := this.ypos 
			;MsgBox % upBound
			if (upBound = 0)
			{
				;MsgBox, bound hit 
				return 
			} 
			this.checkarray(a,up)
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
			if (downBound = 300)
			{
				return 
			}
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
			{
				return 
			}
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
			if (rightBound = 300)
			{
				return 
			}
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


class block 
{
	blockname :=
	blockimagename :=
	xPos := 
	yPos := 
	direction :=
	dimensions := "w100 h100"
	blockimage := A_ScriptDir . "\block.png"

	__New(n, x, y) {
		this.blockname := n
		this.blockimagename := "v" . n
		this.xPos := x
		this.yPos := y 
		this.coordinates := this.getxy() 
	} 

;get methods
	getblockimagename() {
		return this.blockimagename
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
	getblockimage() {
		return this.blockimage 
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
	setblockimage(img) {
		this.playerimage := img
	}
}

