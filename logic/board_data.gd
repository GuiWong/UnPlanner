extends Node2D


var board = [0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,
			0,0,0,0,0,0,0]
			
var next_board = [0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,
			0,0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func initialize():
	board[0]=1
	board[2]=2
	board[3]=3
	board[4]=5
	
func plan_on_day(id,day):
	
	if day >= 28:
		day-=28
		assert(next_board[day]==0)
		next_board[day]=id
		
	else:
	
		assert(board[day]==0)
		board[day]=id
	
func get_free_day_on_week(x):
	
	var free = []
	if x >= 4:
		x-=4
		for i in range(x*7, x*7+6):
		
			if next_board[i] == 0:
				free.append(i)
		
		return free[randi_range(0,free.size()-1)] + 28
		
	
	
	else:
		for i in range(x*7, x*7+6):
		
			if board[i] == 0:
				free.append(i)
		
		return free[randi_range(0,free.size()-1)]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
