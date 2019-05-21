#SingleInstance, force 
#Persistent
#NoTrayIcon


player := new snake_player() 

hpos := " h" . player.height
wpos := " w" . player.width

Gui, Show, %hpos% %wpos%, SNAKE 

sleep 1500
player.advanceSnake()

return 

Esc::
GuiClose:
ExitApp

;----------------------------------- MOVEMENT KEYS -------------------------------------------------------------------------------------------------------------
right::
{
	if (player.changingDirection=1)
		return 
	if (player.dx = -1*player.speed)
		return 
	else 
	{	
		player.changingDirection := 1
		player.dy := 0
		player.dx := player.speed
	}
	return 
}

left::
{
	if (player.changingDirection=1)
		return 
	if (player.dx = player.speed)
		return 
	else 
	{
		player.changingDirection := 1
		player.dy := 0
		player.dx := -1*player.speed
	}
	return 
}

up::
{
	if (player.changingDirection=1)
		return 
	if (player.dy = player.speed)
		return 
	else 
	{
		player.changingDirection := 1
		player.dy := -1*player.speed
		player.dx := 0
	}
	return 
}

down::

{
	if (player.changingDirection=1)
		return 
	if (player.dy = -1*player.speed)
		return 
	else 
	{
		player.changingDirection := 1
		player.dy := player.speed
		player.dx := 0
	}
	return 
}
;----------------------------------- SNAKE CLASS -------------------------------------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Class snake_player ;the snake class contains code for the behavior of the snake and its food 
{	
	snake := [] 							;main array to keep track of snake body 
	snakeimage := A_ScriptDir . "\snake_body.png"			;image for snake body parts 
	foodimage := A_ScriptDir . "\apple.png"				;image for food 	
	speed := 10 							;number of pixels the snake moves per tick - KEEP THIS IN MULTIPLES OF 10  
	dx := this.speed 						;current number of pixels the snake is moving per tick from right to left 
	dy := 0								;current number of pixels the snake is moving per tick from up and down 
	rest := 100							;number of miliseconds between ticks 
	changingDirection := 0						;boolean val for true and false to indicate whether dx and/or dy is changing value 
	bodies := 5							;number of body parts that are created at start up and whenever the snake eats food 
	width := 500							;width of the window 
	height := 500							;height of the window 
	fx := 								;current x position of the food  
	fy := 								;current y position of the food 
	
;----------------------------------- CONSTRUCTORS -------------------------------------------------------------------------------------------------------------	
	__New() { ;new snake and food is created 
		global 
		this.makeSnake()
		this.createFood()
	}

	makeSnake() { ;creates initial snake 
		global 
		local varn, xpos, ypos 
		ind := 0

		Loop, % this.bodies 
		{
			ind := ind+1
			this.snake[ind] := {}
			this.snake[ind]["x"] := (this.width/2)-(10*(ind-1))
			this.snake[ind]["y"] := this.height/2
		}

		for index, point in this.snake 
		{			
			varn := "vS_" . A_Index, xpos := " x" . this.snake[A_Index]["x"], ypos := "y" . this.snake[A_Index]["y"]
			Gui, Add, Picture, %xpos% %ypos% h10 w10 %varn%, % this.snakeimage 
		}
	}

	createFood() { ;creates initial food 
		global 
		xrng := (this.width-10)/10
		Random, rx, 0, xrng				
		yrng := (this.height-10)/10
		Random, ry, 0, yrng
		this.fx := Round(rx*10, -1), this.fy := Round(ry*10,-1) ;use rounding to the ten's place for fx and fy 
		;MsgBox % this.fx 
		for index, point in this.snake 
		{
			if (this.snake[A_Index]["x"]=(this.fx) and this.snake[A_Index]["y"]=(this.fy))
			{
				this.createFood() ;if a point that is chosen is a snake, it trys again 
				return 
			}
		}
		fxpos := " x" . this.fx, fypos := " y" . this.fy
		Gui, Add, Picture, %fxpos% %fypos% h10 w10 vApple, % this.foodimage
	}

;----------------------------------- SNAKE MOVEMENT -------------------------------------------------------------------------------------------------------------
	advanceSnake() { ;function that cycles through movement and collision detection 
		Loop 
		{
			this.moveSnake()
			if (this.isGameOver() = 1)
			{
				MsgBox Game Over
				Reload  
			}
			this.redrawSnake()
			sleep this.rest
			this.changingDirection := 0
			if (this.head["x"]=(this.fx) and this.head["y"]=(this.fy))
			{		 
				this.moveFood()
				Loop, % this.bodies
				{
					this.head := {"x": this.snake[1]["x"] + this.dx, "y": this.snake[1]["y"] + this.dy}
					this.snake.InsertAt(1, this.head)
					this.redrawSnake()
					this.didEatFood()
					sleep this.rest
					this.changingDirection := 0
				}
			}
		}
	}
;----------------------------------- SNAKE MOVEMENT -------------------------------------------------------------------------------------------------------------
	moveSnake() { ;moves snake by adding new entry at the beginning and removes last entry 
		this.head := {"x": this.snake[1]["x"] + this.dx, "y": this.snake[1]["y"] + this.dy}
		this.snake.InsertAt(1, this.head)
		this.snake.Pop()
	}

	redrawSnake() { ;snake image is updated. 			
		for index, point in this.snake 
		{
			zvar := "S_" . A_Index 
			zxpos := " x" . this.snake[A_Index]["x"], zypos := "y" . this.snake[A_Index]["y"] 
			GuiControl, Move, %zvar%, %zxpos% %zypos%
		}
	}

;----------------------------------- FOOD -------------------------------------------------------------------------------------------------------------

	didEatFood() { ;executes when snake collides with piece of food 
		global 
		local var, varn, xpos, ypos
		for index, point in this.snake 
		{
			var := "S_" . A_Index, varn := "v" . var, xpos := " x" . this.snake[A_Index]["x"], ypos := "y" . this.snake[A_Index]["y"]
			GuiControlGet, pID,, %var% ;checks for file path of control picture 
			;MsgBox % pID
			if (pID="") ;checks for an existing snake body without image and creates one
				Gui, Add, Picture, %xpos% %ypos% h10 w10 %varn%, % this.snakeimage
		}

		;this.moveFood()

	}

	moveFood() { ;moves food after being eaten 
		
		xrng := (this.width-10)/10
		Random, rx, 0, xrng
		yrng := (this.height-10)/10
		Random, ry, 0, yrng

		this.fx := Round(rx*10,-1), this.fy := Round(ry*10, -1)
		for index, point in this.snake 
		{
			if (this.snake[A_Index]["x"]=(this.fx) and this.snake[A_Index]["y"]=(this.fy))
			{
				this.moveFood() ;if a point that is chosen is a snake, it trys again 
				return 
			}
		}
		fxpos := " x" . this.fx, fypos := " y" . this.fy
		GuiControl, Move, Apple, %fxpos% %fypos% 
		GuiControl,, Apple, % this.foodimage
		if (this.rest > 10)
			this.rest := this.rest-7 
	}

;----------------------------------- GAME OVER SCREEN -------------------------------------------------------------------------------------------------------------
	isGameOver() { ;checks to see if snake runs into wall or itself 
		if (this.snake[1]["x"]<0 or this.snake[1]["x"]>(this.width-10) or this.snake[1]["y"]<0 or this.snake[1]["y"]>(this.height-10))
			return true 
		for index, point in this.snake 
		{
			if (A_Index < 4)
				continue 
			if (this.snake[1]["x"]=this.snake[A_Index]["x"] and this.snake[1]["y"]=this.snake[A_Index]["y"])
				return true 
		}
	}
}



