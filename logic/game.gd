extends Node2D




var energy = 10
var money = 0
var day = -1
var month = 0

var state = State.time.MORNING


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
	$Card_catalog.initialize()
	$Board/Board_Data.initialize()
	
	
#------------------------------------------------
	#TODO:  Card Builder node/script
	var c_scene = preload("res://node/card/card_base.tscn")
	
	var i = 0
	for c in $Card_catalog.card:
		
		if i != 0:
			var cardd = c_scene.instantiate()
			cardd.build_from_data(c)
			cardd.name = "card_"+str(i)
			$Window/Card_Holder/Cards.add_child(cardd)
		i+=1
		
		
		
		
	for j in range (28):
		
		if $Board/Board_Data.board[j]:
			var caard = get_node("Window/Card_Holder/Cards/card_"+str($Board/Board_Data.board[j]))
			caard.position = Vector2((j%7) * 85 + 8 , 20)
			caard.reparent($Board/Played_cards,false)
		
	$Window/Card_Holder.re_place()
#---------------------------------------------------------

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
#-----------Steps / Time Based -------------

func next_step():
	
	
	print(str(day) +"  -  " +str(state))
	
	match state:
		
		State.time.UNSTARTED:
			
			print("Fatal Error, Unreachable!!!")
			
		State.time.MORNING:
			
			start_day()
			
		State.time.DAY:
			
			solve_day()
			
		State.time.EVENING:
			
			end_day()
			
		State.time.WEEK_END:
			
			end_week()
			
		State.time.WEEK_START:
			
			start_week()
			
		State.time.MONTH_END:
			
			end_month()
			
		State.time.MONTH_LOAD:
			
			load_next_month()
			
		State.time.MONTH_START:
			
			start_month()
	
	pass


func start_day():
	
	state = State.time.DAY
	
func solve_day():
	
	#---------  Start the solving chain, set solve_state
	
	state = State.time.EVENING
	
func end_day():
	
	if day%7 == 6:	
		state = State.time.WEEK_END
		
	else:
		day+=1
		state = State.time.MORNING
	
func end_week():
	
	print("Week_ended!!!")
	if day == 27:
		state = State.time.MONTH_END
	else:
		state = State.time.WEEK_START
		day += 1
	
func start_week():
	
	state = State.time.MORNING
	
func end_month():
	
	print("Month Ended!!!")
	
	state = State.time.MONTH_LOAD
	
func load_next_month():
	
	state = State.time.MONTH_START
	
func start_month():
	
	state = State.time.MORNING
	day = -1
	
	
	
#-------- Initial Setup ---------------

func load_initial_state():

	pass
	
	
#-------------Card Based ---------------
