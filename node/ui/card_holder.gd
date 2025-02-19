extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	re_place()
		


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
