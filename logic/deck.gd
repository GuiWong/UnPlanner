extends Node2D



var cards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func add_card(id):
	
	cards.append(id)
	
func get_card_pos(id):
	
	return cards.find(id,0)
	
func draw_card(id):
	
	return cards.pop_at(get_card_pos(id))
	
func random_draw():
	
	var index=randi_range(0,cards.size()-1)
	print("selected card number "+ str(index))
	return cards.pop_at(index)
