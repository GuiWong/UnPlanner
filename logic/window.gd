extends Node2D




var selected_node = null
var selected_id = null

signal validate(c_1,c_2)
signal close

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	#$Card_Holder.connect("card_selected",self.on_card_selected)





func on_card_selected(card_id,node):
	
	
	print("card selected!!!")
	selected_node = node
	selected_id = card_id
	
	toggle_button_visible(true)
	
	
func toggle_button_visible(is_visible):
	
	
	$Buttons.visible=is_visible
	
func cancel_selection():
	
	selected_node = null
	selected_id = null
	
	toggle_button_visible(false)
	
func validate_selection():
	
	print(selected_id)
	print(selected_node)
	
	var ret = $Card_Holder/Cards.get_children()
	var i = ret.find(selected_node)
	ret.pop_at(i)
	
	emit_signal("validate",ret[0] , ret[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_but_pressed():
	emit_signal("close")
