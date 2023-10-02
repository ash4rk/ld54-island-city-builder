extends CenterContainer

export(NodePath) var OPTIONS_PATH

onready var onboarding_screen = preload("res://scenes/ui/onboarding.tscn")
onready var start_button = $PanelContainer/VBoxContainer/StartButton
onready var options_button = $PanelContainer/VBoxContainer/OptionsButton
onready var about_button = $PanelContainer/VBoxContainer/AboutButton
onready var options_menu = get_node(OPTIONS_PATH)

func _ready():
	start_button.connect("pressed", self, "_on_start_button_pressed")
	options_button.connect("pressed", self, "_on_options_button_pressed")
	about_button.connect("pressed", self, "_on_about_button_pressed")
	
func _on_start_button_pressed():
	Global.reset()
	Global.game_loop()
	self.hide()
	$"../UI".show()
	get_parent().add_child(onboarding_screen.instance())

func _on_options_button_pressed():
	options_menu.show()

func _on_about_button_pressed():
	pass
