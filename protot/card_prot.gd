extends Node2D




@export var card_name ="work"
@export var icon_frame = 0
@export var energ_cost = -3
@export var money_cost = 20

signal pressed


func _ready():
	pass # Replace with function body.
	$Label.text=card_name
	$Label2.text=str(energ_cost)
	$Label3.text=str(money_cost)
	$Sprite2D2.frame=icon_frame
	
	if energ_cost == 0:
		
		$Label2.visible = false
		$Sprite2D3.visible=false
		
	if money_cost == 0:
		
		$Label3.visible = false
		$Sprite2D4.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	emit_signal("pressed")
