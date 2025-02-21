extends Node2D




var energy = 10
var money = 0
var day = 0
var month = 0

var state = State.time.MORNING
var solve_state = State.solve.NONE
var window_state = State.window_solve.NONE
var paused = false

var card_queue = []

func set_speed(x):
	
	if x == 0:
		$Timer.stop()
		
	else:
	
		$Timer.wait_time=0.5/x
		$Timer.start()


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
			cardd.connect("pressed",$Window/Card_Holder.on_card_selected)
			cardd.set_card_storage(State.stored_in.DECK)
			$Deck.add_card(i)
			
		i+=1
		
	print("deck data:")
	print($Deck.cards)
	
	
		
	for j in range (28):
		
		if $Board/Board_Data.board[j]:
			var caard = get_node("Window/Card_Holder/Cards/card_"+str($Board/Board_Data.board[j]))
			caard.position = Vector2((j%7) * 85 + 8 , 16)
			caard.set_card_storage(State.stored_in.BOARD)
			caard.reparent($Board/Played_cards,false)
			
			$Deck.draw_card($Board/Board_Data.board[j])
		
	$Window/Card_Holder.re_place()
	
	$Draw_window/Card_Holder.set_zoom_level(2)
	
	#print("deck data:")
	#print($Deck.cards)
	#draw_3_test()
	
	$Draw_window.connect("validate",validate_draw)
#---------------------------------------------------------

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		$Window/Card_Holder.filter_place(State.stored_in.DECK)
	if Input.is_action_just_pressed("ui_right"):
		$Window/Card_Holder.filter_place(State.stored_in.DISCARD)
	
	
	
#-----------test area---------------

func draw_3_test():
	
	var c = 0
	for i in range(3):
		
		c = $Deck.random_draw()
		print(c)
		#TODO : get_card_node func wich do disconnect
		$Window/Card_Holder.get_card_by_id(c).disconnect("pressed",$Window/Card_Holder.on_card_selected)
		$Draw_window/Card_Holder.add_card($Window/Card_Holder.get_card_by_id(c))
		
	$Draw_window/Card_Holder.re_place()
	$Window/Card_Holder.filter_place(State.stored_in.DECK)
	
#-----------Steps / Time Based -------------


func next_window_step():
	
	match window_state:
		
		State.window_solve.WAITING:
			
			pass
			
		State.window_solve.DRAW_DONE:
			
			print("draw validated")
			window_state = State.window_solve.DRAW_FOCUS
			
			
		State.window_solve.DRAW_FOCUS:
			
			card_queue[0].reparent($Desk/Focus_point,false)
			card_queue[0].position = Vector2.ZERO
			window_state = State.window_solve.DRAW_SOLVE
			
		State.window_solve.DRAW_SOLVE:
			
			var day = $Board/Board_Data.get_free_day_on_week(floor(day/7))
			$Board/Board_Data.plan_on_day(card_queue[0].card_id,day)
			
			card_queue[0].position = Vector2((day%7) * 85 + 8 , 16+ 150 * floor(day/7))
			card_queue[0].set_card_storage(State.stored_in.BOARD)
			card_queue[0].reparent($Board/Played_cards,false)
			
			card_queue.pop_front()
			
			if card_queue.size() > 0:
				window_state = State.window_solve.DRAW_FOCUS
			else:
			
				window_state = State.window_solve.DRAW_DISPOSE
				
		State.window_solve.DRAW_DISPOSE:
			
			print("done drawing")
			$Draw_window/Card_Holder/Cards.get_child(0).disconnect("pressed",$Draw_window/Card_Holder.on_card_selected)
			$Deck.add_card($Draw_window/Card_Holder/Cards.get_child(0).card_id)
			$Window/Card_Holder.add_card($Draw_window/Card_Holder/Cards.get_child(0))
			$Draw_window.visible=false
			
			window_state = State.window_solve.NONE
			

func next_solve_step():
	
	match solve_state:
		
		State.solve.SOLVE_EMPTY:
		
			solve_empty_day()
		
		State.solve.SOLVE_LOAD:
			
			
			load_solve_card()
			
			
		State.solve.SOLVE_PAY:
			
			pay_solve_card()
			
		State.solve.SOLVE_DISPOSE:
			
			dispose_solve_card()

func next_step():
	
	if paused:
		
		return 0
	if window_state != State.solve.NONE:
		
		next_window_step()
		return 0
	
	if solve_state != State.solve.NONE:
	
		next_solve_step()
		return 0
	
	print( "Day: " +str(day) +"  [  " +str(state) + " - "+ str(solve_state))
	print("money: "+ str(money) + " | Energy: "+str(energy))
	
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
	
	move_day_marker()
	
func solve_day():
	
	#---------  Start the solving chain, set solve_state
	
	#TODO: getters/setters!!!!
	if $Board/Board_Data.board[day] != 0:
		
		solve_state = State.solve.SOLVE_LOAD
	else:
		
		solve_state = State.solve.SOLVE_EMPTY
	
	state = State.time.EVENING
	
func end_day():
	
	if day%7 == 6:	
		state = State.time.WEEK_END
		
	else:
		day+=1
		state = State.time.MORNING
	
func end_week():
	
	print("Week_ended!!!")
	
	start_draw()
	
	if day == 27:
		state = State.time.MONTH_END
	else:
		state = State.time.WEEK_START
		day += 1
	
func start_week():
	
	
	for c_id in $Discard.cards:
		
		var card = $Card_catalog.card[c_id]
		var card_node = get_node("Window/Card_Holder/Cards/card_"+str(c_id))
		
		if card.timer_value == 0:
			$Discard.draw_card(c_id)
			$Deck.add_card(c_id)
			card_node.stored_in = State.stored_in.DECK
			
		else:
			
			card.timer_value -= 1
			card_node.build_from_data(card)
	
	state = State.time.MORNING
	
func end_month():
	
	print("Month Ended!!!")
	
	state = State.time.MONTH_LOAD
	
func load_next_month():
	
	state = State.time.MONTH_START
	
func start_month():
	
	state = State.time.MORNING
	day = -1
	
func move_day_marker():
	
	$Board/Day_marker.position = Vector2 ( (day%7)*85 + 48 , floor(day/7) *150 + 8)
	
#-------------------Time speed based

func force_pause():
	
	$Timer.stop()
	paused = true
	
func replay():
	
	paused=false
	$Timer.start()
#---------------window_based------------------

func start_draw():
	
	$Draw_window.visible=true
	
	print("draw...")
	print($Deck.cards)
	
	var c = 0
	for i in range(3):
		
		c = $Deck.random_draw()
		print(c)
		#TODO : get_card_node func wich do disconnect
		$Window/Card_Holder.get_card_by_id(c).disconnect("pressed",$Window/Card_Holder.on_card_selected)
		$Draw_window/Card_Holder.add_card($Window/Card_Holder.get_card_by_id(c))
		
	$Draw_window/Card_Holder.re_place()
	$Window/Card_Holder.filter_place(State.stored_in.DECK)
	
	window_state= State.window_solve.WAITING

func validate_draw(c_1,c_2):
	
	window_state= State.window_solve.DRAW_DONE
	card_queue = []
	card_queue.append(c_1)
	card_queue.append(c_2)
	
	
func open_deck():
	
	$Window/Card_Holder.filter_place(State.stored_in.DECK)
	$Window.visible=true
	
	force_pause()
	
func open_discard():
	
	$Window/Card_Holder.filter_place(State.stored_in.DISCARD)
	$Window.visible=true
	
	force_pause()
	
func close_deck_window():
	
	$Window.visible=false
	replay()

	
	
#-------- Initial Setup ---------------

func load_initial_state():

	pass
	
	
#-------------Card Based ---------------


#Solving_functions

func solve_empty_day():
	
	energy += 1
	
	$Ui/Top_Bar/Energy_Ui.update_ui_value(energy)
	solve_state = State.solve.NONE

func load_solve_card():
	
	var caardd = get_node("Board/Played_cards/card_"+str($Board/Board_Data.board[day]))
	caardd.reparent($Desk/Focus_point,false)
	caardd.position = Vector2.ZERO
				
	solve_state = State.solve.SOLVE_PAY
	
func pay_solve_card():
	
	
	#TODO setter/getter
	money += $Card_catalog.card[$Board/Board_Data.board[day]].money_cost
	energy += $Card_catalog.card[$Board/Board_Data.board[day]].energy_cost
	
	$Ui/Top_Bar/Energy_Ui.update_ui_value(energy)
	$Ui/Top_Bar/Money_Ui.update_ui_value(money)
	
	solve_state = State.solve.SOLVE_DISPOSE
	
	
func dispose_solve_card():
	
	#Need to handle deck replacement!!!
	
	
	var card = $Card_catalog.card[get_node("Desk/Focus_point").get_child(0).card_id]
	var card_node = get_node("Desk/Focus_point").get_child(0)
	if card.weekly_value == 0:
	
	#TODO:  Better access to cardand card data!
	
		card.timer_value = card.discard_timer_base
		
		$Discard.add_card(card_node.card_id)
		
		card_node.stored_in =State.stored_in.DISCARD
		card_node.reparent($Window/Card_Holder/Cards,false)
	
	else:
		#TODO: function for doing that
		var day = $Board/Board_Data.get_free_day_on_week(floor(day / 7) +card.weekly_value)
		$Board/Board_Data.plan_on_day(card.card_id,day)
			
		card_node.position = Vector2((day%7) * 85 + 8 , 16+ 150 * floor(day/7))
		card_node.set_card_storage(State.stored_in.BOARD)
		card_node.reparent($Board/Played_cards,false)
	
	$Window/Card_Holder.re_place()
	
	solve_state = State.solve.NONE
