extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func build_from_data(card_o):
	
	$Card_Name.text = card_o.card_name
	$Card_Icon.frame = card_o.icon_id
	
	$Costs/Energy_Cost.set_value(card_o.energy_cost)
	$Costs/Money_cost.set_value(card_o.money_cost)
	
	
	#TODO:  Better Icon Handeling
	
	if card_o.weekly_value == 0:
		
		$Tags/Label2.visible = false
		$Tags/TagIcon2.visible = false
	
	else:
		
		$Tags/Label2.visible = true
		$Tags/TagIcon2.visible = true
		
		$Tags/Label2.text = str(card_o.weekly_value)
		
	$Tags/Label.text = str(card_o.discard_timer_base)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
