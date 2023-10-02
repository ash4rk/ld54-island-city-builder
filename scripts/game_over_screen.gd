extends Control

onready var restart_button = $VBoxContainer/HBoxContainer/RestartButton
onready var overview_button = $VBoxContainer/HBoxContainer/OverviewButton

func _ready():
	Global.connect("game_over", self, "_game_over_event")
	restart_button.connect("pressed", self, "_on_restart_button_pressed")
	overview_button.connect("pressed", self, "_on_overview_button_pressed")

func _game_over_event():
	_counting_the_results()
	self.show()

func _on_overview_button_pressed():
	$BG.hide()
	$VBoxContainer/BankruptcyMessage.hide()
	$VBoxContainer/NormalMessage.hide()
	$VBoxContainer.anchor_bottom = 0.0
	overview_button.hide()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _counting_the_results():
	if Global.income <= 0 and Global.coins < 0:
		$VBoxContainer/BankruptcyMessage.show()
	else:
		$VBoxContainer/NormalMessage.show()
