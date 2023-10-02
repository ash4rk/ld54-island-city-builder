extends Control

const REQUERED_BUDGET: int = 1300
const LOW_LEVEL_ATTRACTIVENESS: int = 0
const HIGH_LEVEL_ATTRACTIVENESS: int = 130
const LOW_LEVEL_TECHNOLOGIES: int = 0
const HIGH_LEVEL_TECHNOLOGIES: int = 130

onready var green_panel_stylebox = preload("res://assets/green_panel_style_box.tres")
onready var red_panel_stylebox = preload("res://assets/red_panel_style_box.tres")
onready var restart_button = $VBoxContainer/HBoxContainer/RestartButton
onready var overview_button = $VBoxContainer/HBoxContainer/OverviewButton
onready var line_chart_button = $VBoxContainer/HBoxContainer/LineChartButton

onready var budget_mark = $VBoxContainer/GameOverMessage/VBoxContainer/Budget/BudgetMark
onready var techonologies_mark = $VBoxContainer/GameOverMessage/VBoxContainer/Technologies/TechnologiesMark
onready var attractiveness_mark = $VBoxContainer/GameOverMessage/VBoxContainer/Attractiveness/AttractivenessMark

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
		_generate_game_over_text()
	$VBoxContainer/GameOverMessage.show()
	
func _generate_game_over_text():
	var game_over_text = "\n"
	$VBoxContainer/GameOverMessage/VBoxContainer/Budget/BudgetValue.text = str(Global.coins)
	$VBoxContainer/GameOverMessage/VBoxContainer/Technologies/TechnologiesValue.text = str(Global.technologies)
	$VBoxContainer/GameOverMessage/VBoxContainer/Attractiveness/AttractivenessValue.text = str(Global.attractiveness)
	
	# Budget check
	if Global.coins > REQUERED_BUDGET:
		budget_mark.text = "- AWESOME!"
		budget_mark.modulate = Color.green
	else:
		budget_mark.text = "- BAD!"
		budget_mark.modulate = Color.red

	# Technologies check
	if Global.technologies <= LOW_LEVEL_TECHNOLOGIES:
		techonologies_mark.text = "- BAD!"
		techonologies_mark.modulate = Color.red
	elif Global.technologies > LOW_LEVEL_TECHNOLOGIES and Global.attractiveness < HIGH_LEVEL_TECHNOLOGIES:
		techonologies_mark.text = "- Good"
		techonologies_mark.modulate = Color.yellow
	else:
		techonologies_mark.text = "- AWESOME!"
		techonologies_mark.modulate = Color.green

	# Attractiveness check
	if Global.attractiveness <= LOW_LEVEL_ATTRACTIVENESS:
		attractiveness_mark.text = "- BAD!"
		attractiveness_mark.modulate = Color.red
	elif Global.attractiveness > LOW_LEVEL_ATTRACTIVENESS and Global.attractiveness < HIGH_LEVEL_ATTRACTIVENESS:
		attractiveness_mark.text = "- Good"
		attractiveness_mark.modulate = Color.yellow
	else:
		attractiveness_mark.text = "- AWESOME!"
		attractiveness_mark.modulate = Color.green
	
	return game_over_text
