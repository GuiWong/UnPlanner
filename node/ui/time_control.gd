extends Control



signal pressed(x)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_button_pressed(i):
	
	for x in range(4):
		
		if x != i:
			
			get_child(x).button_pressed = false
			
	emit_signal("pressed",i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
