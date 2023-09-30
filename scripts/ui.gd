extends Control

onready var buttons = $BuildingContainer/BuildingButtons/HBoxContainer.get_children()
onready var coins_value = $StatsContainer/GridContainer/CoinsValue

func _ready():
	print("ui_ready")
	Global.connect("update_stats", self, "_up_update_stats_event")

func _up_update_stats_event():
	for button in buttons:
		# TODO: Change to enable/disable
		if button.cost > Global.coins:
			button.modulate = Color.red
		else:
			button.modulate = Color.white
	coins_value.text = str(Global.coins)
