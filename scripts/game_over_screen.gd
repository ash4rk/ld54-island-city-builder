extends Control

const REQUERED_BUDGET: int = 500
const LOW_LEVEL_ATTRACTIVENESS: int = 0
const HIGH_LEVEL_ATTRACTIVENESS: int = 25
const LOW_LEVEL_TECHNOLOGIES: int = 0
const HIGH_LEVEL_TECHNOLOGIES: int = 25

onready var green_panel_stylebox = preload("res://assets/green_panel_style_box.tres")
onready var red_panel_stylebox = preload("res://assets/red_panel_style_box.tres")
onready var restart_button = $VBoxContainer/HBoxContainer/RestartButton
onready var overview_button = $VBoxContainer/HBoxContainer/OverviewButton
onready var line_chart_button = $VBoxContainer/HBoxContainer/LineChartButton

func _ready():
	Global.connect("game_over", self, "_game_over_event")
	restart_button.connect("pressed", self, "_on_restart_button_pressed")
	overview_button.connect("pressed", self, "_on_overview_button_pressed")
	line_chart_button.connect("pressed", self, "_on_line_chart_button_pressed")
	_counting_the_results()

func _game_over_event():
	_counting_the_results()
	self.show()

func _on_overview_button_pressed():
	$BG.hide()
	$VBoxContainer/GameOverMessage.hide()
	$VBoxContainer.anchor_bottom = 0.0
	overview_button.hide()

func _on_line_chart_button_pressed():
	$LineChartContainer.show()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _counting_the_results():
	if Global.income <= 0 and Global.coins < 0:
		# Bankruptcy Message
		$VBoxContainer/GameOverMessage.add_stylebox_override("panel", red_panel_stylebox)
		$VBoxContainer/GameOverMessage/VBoxContainer/CongratLabel.text = "Oh no, you're bankrupt!"
		$VBoxContainer/GameOverMessage/VBoxContainer/MessageLabel.hide()
	else:
		# Normal Message
		$VBoxContainer/GameOverMessage.add_stylebox_override("panel", green_panel_stylebox)
		$VBoxContainer/GameOverMessage/VBoxContainer/CongratLabel.text = "Congratulations!"
		$VBoxContainer/GameOverMessage/VBoxContainer/MessageLabel.show()
		$VBoxContainer/GameOverMessage/VBoxContainer/MessageLabel.text = "You've made some accomplishments!\n"
		$VBoxContainer/GameOverMessage/VBoxContainer/MessageLabel.text += _generate_game_over_text()
		
	$VBoxContainer/GameOverMessage.show()
	
func _generate_game_over_text():
	var game_over_text = "\n"
	
	# Budget check
	if Global.coins > REQUERED_BUDGET:
		game_over_text += "GOOD BUDGET!\n"
	else:
		game_over_text += "BAD BUDGET!\n"

	# Technologies check
	if Global.technologies < LOW_LEVEL_TECHNOLOGIES:
		game_over_text += "BAD TECHNOLOGIES!\n"
	elif Global.technologies > LOW_LEVEL_TECHNOLOGIES and Global.attractiveness < HIGH_LEVEL_TECHNOLOGIES:
		game_over_text += "MEAN TECHNOLOGIES!\n"
	else:
		game_over_text += "GOOD TECHNOLOGIES!\n"

	# Attractiveness check
	if Global.attractiveness < LOW_LEVEL_ATTRACTIVENESS:
		game_over_text += "BAD ATTRACTIVENESS!"
	elif Global.attractiveness > LOW_LEVEL_ATTRACTIVENESS and Global.attractiveness < HIGH_LEVEL_ATTRACTIVENESS:
		game_over_text += "MEAN ATTRACTIVENESS!"
	else:
		game_over_text += "GOOD ATTRACTIVENESS!"
	
	return game_over_text
