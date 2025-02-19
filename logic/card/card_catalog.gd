extends Node2D


class Card:
	
	var card_name ="name"
	var icon_id = 4
	var energy_cost = 0
	var money_cost = 0
	
	var weekly_value = 0
	var month_wait = 0
	
	var discard_timer_base = 0
	var timer_value = 0
	
	var solve_effect = 0 #0:justcost , 1 psy , 2 shop 
	var erase_effect = 0 #0 no effect 
	
	#may need to have morecontrol on effects
	
	var solved = 0
	var discarded = 0
	
	func _init(named,icon,energy,money,week=0,month=0,timer=0,effect =0,erase = 0):
		
		self.card_name=named
		self.icon_id = icon
		self.energy_cost = energy
		self.money_cost = money
		self.weekly_value=week
		self.month_wait=month
		self.discard_timer_base = timer
		
		self.solve_effect = effect
		self.erase_effect = erase
		
		
	

var card = []



# Called when the node enters the scene tree for the first time.
func _ready():
	
	

	pass

func initialize():
	
	card.append(Card.new("Dummy",8,0,0,0,0))
	card.append(Card.new("work",0,-3,20,1,0))
	card.append(Card.new("work",0,-3,20,1,0))
	card.append(Card.new("therapy",4,0,0,2,0,0,1,0))
	card.append(Card.new("Shop",2,0,0,0,0,1,2,0))
	card.append(Card.new("bills",2,-2,-50,0,1, 0 , 0 , 0))
	
						#name,       icon,    
						#			|			Weekly
						#			|	Energy	  | Monthly
						#			|	  | money |  |  Timer
	card.append(Card.new("laundry",  5,  -2,  0,  0,  0,  1))
	card.append(Card.new("clean",    3,  -2,  0,  0,  0,  1))
	card.append(Card.new("paperwork",6,  -2,  0,  0,  0,  2))
	
	card.append(Card.new("party",    4,   2,-15,  0,  0,  2))
	card.append(Card.new("takeout",  4,   1,-10,  0,  0,  0))
	

func _process(delta):
	pass
