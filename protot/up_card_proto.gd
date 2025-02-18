extends Node2D


@export var title = "organize"
@export var icon_index =1
signal pressed
func _ready():
	$Label.text = title
	
	if icon_index ==8:
		$Icons2.visible=true
	else:
		$Icons.frame=icon_index


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	emit_signal("pressed")
