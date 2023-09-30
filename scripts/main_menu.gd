extends CenterContainer


func _ready():
	$VBoxContainer/StartButton.connect("pressed", self, "_on_start_button_pressed")
	
func _on_start_button_pressed():
	Global.game_loop()
	self.hide()
	$"../UI".show()
