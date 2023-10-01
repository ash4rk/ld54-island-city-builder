extends Control

onready var buttons = $BuildingContainer/BuildingButtons/HBoxContainer.get_children()
onready var coins_value = $StatsContainer/VBoxContainer/Coins/CoinsValue
onready var income_value = $StatsContainer/VBoxContainer/Coins/IncomeValue
onready var move_info_label = $MoveInfoContainer/VBoxContainer/HBoxContainer/MoveValueLabel
onready var skip_button = $MoveInfoContainer/VBoxContainer/SkipButton
onready var technologies_pb = $StatsContainer/VBoxContainer/TechnologyPB
onready var attractiveness_pb = $StatsContainer/VBoxContainer/AttractivenessPB

func _ready():
	print("ui_ready")
	skip_button.connect("pressed", self, "_skip_button_pressed")
	Global.connect("update_stats", self, "_update_stats_event")
	Global.connect("next_move", self, "_next_move_event")

func _update_stats_event():
	for button in buttons:
		# TODO: Change to enable/disable
		button.disabled = button.cost > Global.coins

	_update_coins_value()
	_update_pb_values()

func _update_coins_value():
	coins_value.text = str(Global.coins)
	
	var income_text = ""
	if Global.income > 0:
		income_text = "+"
		income_value.modulate = Color.green
	elif Global.income < 0:
		income_text = "-"
		income_value.modulate = Color.red
	elif Global.income == 0:
		income_text = "+"
		income_value.modulate = Color.white
		
	income_value.text = income_text+str(abs(Global.income))

func _update_pb_values():
	technologies_pb.value = Global.technologies
	attractiveness_pb.value = Global.attractiveness

func _next_move_event():
	move_info_label.text = str(Global.current_step) + "/" + str(Global.MAX_STEPS)

func _skip_button_pressed():
	Global.next_move()
