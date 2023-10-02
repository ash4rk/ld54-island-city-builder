extends Control

onready var next_button = $NextButton

func _ready():
	next_button.connect("pressed", self, "_on_next_button_pressed")

func _on_next_button_pressed():
	if $Page1.visible:
		$Page1.hide()
		$Page2.show()
	else:
		self.hide()
