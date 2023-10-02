extends CenterContainer

onready var onboarding_screen = preload("res://scenes/ui/onboarding.tscn")

func _ready():
	$PanelContainer/VBoxContainer/StartButton.connect("pressed", self, "_on_start_button_pressed")
	
func _on_start_button_pressed():
	Global.reset()
	Global.game_loop()
	self.hide()
	$"../UI".show()
	get_parent().add_child(onboarding_screen.instance())
