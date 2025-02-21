extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_ui_value(x):
	
	$Label.text = str(x)
	$ProgressBar.value = x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
