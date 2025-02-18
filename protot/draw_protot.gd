extends Node2D


signal test(a , b)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_card_1_pressed():
	emit_signal("test",$Card_2,$Card_3)
	print("test?")


func _on_card_2_pressed():
	emit_signal("test",$Card_1,$Card_3)

func _on_card_3_pressed():
	emit_signal("test",$Card_2,$Card_1)
