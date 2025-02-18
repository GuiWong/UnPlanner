extends Node2D




var energy = 10
var money = 0
var day = -1
var month = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
#-----------Steps / Time Based -------------

func start_day():
	
	pass
	
func solve_day():
	
	pass
	
func end_day():
	
	if day%7 == 6:	
		end_week()
	
func end_week():
	
	pass
	
func start_week():
	
	pass
	
func end_month():
	
	pass
	
func load_next_month():
	
	pass
	
func start_month():
	
	pass
	
	
#-------- Initial Setup ---------------

func load_initial_state():

	pass
	
	
#-------------Card Based ---------------
