extends Node2D




var energy = 10
var money = 0
var delete_active = false
var lock_at_3 = true
var spots=[0,0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	for i in range(4):
#		for j in range(7):
		#	var s = $Day.duplicate() #Sprite2D.new()
		#	s.texture = Teture#Texture.new()
		#	s.hframes=3
		#	s.vframes=2
		#	s.frame=randi_range(0,5)
		#	$Monthprot.add_child(s)
		#	s.position=Vector2(j*85 , i * 150)
		
	var tc = preload("res://protot/card_prot.tscn")
	var card = tc.instantiate()
	card.card_name = "Therapy"
	card.energ_cost = 0
	card.money_cost = 0
	card.icon_frame = 1
	card.position = Vector2(3*85 + 10 , 0 + 20)
	card.name="proto_therapy"
	$Cards.add_child(card)
	
	card = tc.instantiate()
	card.card_name = "Bills"
	card.energ_cost = -2
	card.money_cost = -50
	card.icon_frame = 2
	card.position = Vector2(4*85 + 10 , 0 + 20)
	card.name="proto_bills"
	$Cards.add_child(card)

var day = -1

func update_energy(val):
	energy += val
	$ProtoUi/Ener_ui/ProgressBar.value=energy
	$ProtoUi/Ener_ui/Label2.text=str(energy)
	
func update_money(val):
	money += val
	$ProtoUi/Mon_ui/Label2.text=str(money)

func test_player():
	
	$window_anchor/Choice_Window.visible = false
	
	day += 1
	$Player/ColorRect.position=Vector2((day%7) * 85 + 48, (day / 7 ) * 150 + 4)
	
	while $Active.get_child_count() > 0:
			if $Active.get_child(0).name == "CardProt" or $Active.get_child(0).name == "CardProt2" :
				var d = randi_range(0,4)
				while spots[d]:
					d = randi_range(0,4)
				spots[d]=1
				$Active.get_child(0).position=Vector2(d*85+10,150+20)
				$Active.get_child(0).reparent($Cards,false)
			elif $Active.get_child(0).name == "proto_therapy":
				var d = randi_range(0,4)
				$Active.get_child(0).position=Vector2(d*85+10,2*150+20)
				$Active.get_child(0).reparent($Cards,false)
			else:
				$Active.remove_child($Active.get_child(0))
	
	if day == 0:
		$Cards/CardProt.position=Vector2.ZERO
		$Cards/CardProt.reparent($Active,false)
		
		update_energy(-3)
		update_money(20)
		
	elif day == 1 or day == 4 or day ==5:
		
		update_energy(1)
		
	elif day == 2:
		$Cards/CardProt2.position=Vector2.ZERO
		$Cards/CardProt2.reparent($Active,false)
		
		update_energy(-3)
		update_money(20)
		
	elif day == 3:
		$Cards/proto_therapy.position=Vector2.ZERO
		$Cards/proto_therapy.reparent($Active,false)
		$window_anchor/Choice_Window.visible = true
		
		if lock_at_3:
			$ProtoUi/Button.disabled = true
		
		#update_energy(-3)
		#update_money(20)
	
		
	elif day == 6:
		
		$window_anchor/Draw_protot.visible=true
		update_energy(1)
		
	#else:
		
	#	while $Active.get_child_count() > 0:
		#	$Active.remove_child($Active.get_child(0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and delete_active:#Input.is_action_just_pressed(MOUSE_BUTTON_LEFT):
		
		var popos = get_global_mouse_position() - $Monthprot.position
		if popos.x <= 85 * 5 and popos.x >= 85*4:
				if popos.y <= 150  and popos.y >= 0:
					#print("touche")
					$Cards/proto_bills.position=Vector2(32,0)
					$Cards/proto_bills.reparent($Active,false)
					$ProtoUi/Rem_ui/Label.text = "X 2"
					
					lock_at_3 = false
					$ProtoUi/Button.disabled = false
					
		delete_active = false
		$Proto_mouse_icon.visible = false

func _on_erase_but_pressed():
	$Proto_mouse_icon.visible = true
	delete_active = true
	
func proto_draw(card_1,card_2):
	print("test2")
	card_1.reparent($Cards,false)
	var d = randi_range(0,6)
	while spots[d]:
		d = randi_range(0,6)
	spots[d]=1
	card_1.position=Vector2(d*85+10,150+20)
	
	card_2.reparent($Cards,false)
	
	d = randi_range(0,6)
	while spots[d]:
		d = randi_range(0,6)
	spots[d]=1
	card_2.position=Vector2(d*85+10,150+20)
	
	#card_1.disconnect("pressed")
	#card_2.disconnect("pressed")
	
	
	$window_anchor/Draw_protot.visible=false
