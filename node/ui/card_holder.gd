extends Node2D



signal card_selected(id,node)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	re_place()
	
func set_zoom_level(x):

	$Cards.scale=Vector2(x,x)
	
	
func add_card(node):
	
	node.reparent($Cards,false)
	node.connect("pressed",on_card_selected)
	
func get_card_by_id(id):
	
	print("getting card "+str(id))
	print(get_node("Cards/card_"+str(id)))
	return get_node("Cards/card_"+str(id))
	
	
func on_card_selected(node):
	
	print("selected card")
	print(node)
	print(node.card_id)
	
	emit_signal("card_selected",node.card_id,node)
		
		
		
func filter_place(place):
	
	var x = $Cards.get_child_count()
	var c_po = Vector2(0,8)
	var h_po = Vector2(1000,1000)
	var c=0
	for i in range(0,x):
		
		if $Cards.get_child(i).stored_in == place:
			c_po.y = 144 * floor(c/8) 
			c_po.x = 80 * (c%8)
			$Cards.get_child(i).position = c_po
			c+=1
		else:
			$Cards.get_child(i).position = h_po
			


func re_place():
	
	var x = $Cards.get_child_count()
	var c_po = Vector2(0,8)
	for i in range(0,x):
		c_po.y = 144 * floor(i/8) 
		c_po.x = 80 * (i%8)
		$Cards.get_child(i).position = c_po
		#$Cards.get_child(i).get_child(5).frame = randi_range(0,7)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
