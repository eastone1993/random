#SingleInstance, force 
#Persistent
#NoTrayIcon


player := new snake_player() 


Gui, Show, h1000 w1000, SNAKE 

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
	snake := [{"x": 500, "y": 500},{"x": 490, "y": 500},{"x": 480, "y": 500},{"x": 470, "y": 500},{"x": 460, "y": 500}]
	snakeimage := A_ScriptDir . "\snake_body.png"
	speed := 10 
	dx := this.speed
	dy := 0
	rest := 100
	changingDirection := 0
	foodimage := A_ScriptDir . "\apple.png"
	fx := 
	fy := 
;----------------------------------- CONSTRUCTORS -------------------------------------------------------------------------------------------------------------	
	__New() { ;new snake and food is created 
		this.makeSnake()
		this.createFood()
	}

	makeSnake() { ;creates initial snake 
		global 
		local varn, xpos, ypos 
		for index, point in this.snake 
		{			
			varn := "vS_" . A_Index, xpos := " x" . this.snake[A_Index]["x"], ypos := "y" . this.snake[A_Index]["y"]
			Gui, Add, Picture, %xpos% %ypos% h10 w10 %varn%, % this.snakeimage 
		}
	}

	createFood() { ;creates initial food 
		global 
		Random, rx, 0, 99
		Random, ry, 0, 99
		this.fx := rx, this.fy := ry
		for index, point in this.snake 
		{
			if (this.snake[A_Index]["x"]=(this.fx*10) and this.snake[A_Index]["y"]=(this.fy*10))
			{
				this.createFood() ;if a point that is chosen is a snake, it trys again 
				return 
			}
		}
		fxpos := " x" . this.fx*10, fypos := " y" . this.fy*10
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
			if (this.head["x"]=(this.fx*10) and this.head["y"]=(this.fy*10))
			{		 
				this.moveFood()
				this.head := {"x": this.snake[1]["x"] + this.dx, "y": this.snake[1]["y"] + this.dy}
				this.snake.InsertAt(1, this.head)
				this.redrawSnake()
				this.didEatFood()
				sleep this.rest
				
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
		Random, rx, 0, 99
		Random, ry, 0, 99
		this.fx := rx, this.fy := ry
		for index, point in this.snake 
		{
			if (this.snake[A_Index]["x"]=(this.fx*10) and this.snake[A_Index]["y"]=(this.fy*10))
			{
				this.moveFood() ;if a point that is chosen is a snake, it trys again 
				return 
			}
		}
		fxpos := " x" . this.fx*10, fypos := " y" . this.fy*10
		GuiControl, Move, Apple, %fxpos% %fypos% 
		GuiControl,, Apple, % this.foodimage
		if (this.rest > 25)
			this.rest := this.rest-5 
	}

;----------------------------------- GAME OVER SCREEN -------------------------------------------------------------------------------------------------------------
	isGameOver() { ;checks to see if snake runs into wall or itself 
		if (this.snake[1]["x"]<0 or this.snake[1]["x"]>990 or this.snake[1]["y"]<0 or this.snake[1]["y"]>990)
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



