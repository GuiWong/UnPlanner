extends Node2D


class Card:
	
	var card_name ="name"
	var icon_id = 4
	var energy_cost = 0
	var money_cost = 0
	
	var weeklyvalue = 0
	var month_wait = 0
	
	func _init(named,icon,energy,money,week,month):
		
		self.card_name=named
		self.icon_id = icon
		self.energy_cost = energy
		self.money_cost = money
		
		
	

var card = []



# Called when the node enters the scene tree for the first time.
func _ready():
	
	card.append(Card.new("work",0,-3,20,1,0))
	card.append(Card.new("work",0,-3,20,1,0))
	card.append(Card.new("bills",2,-2,-50,0,1))
	

	var xx = 200
	for c in card:
		var test = preload("res://protot/card_prot.tscn")
		var carde = test.instantiate()
		carde.card_name = c.card_name
		carde.energ_cost = c.energy_cost
		carde.money_cost = c.money_cost
		carde.icon_frame = c.icon_id
		carde.position = Vector2(xx , 0 + 20)
		carde.name="proto_therapy"
		xx += 200
			
		$"../Board/Played_cards".add_child(carde)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
