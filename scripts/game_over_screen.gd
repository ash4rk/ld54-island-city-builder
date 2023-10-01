extends Control

func _ready():
	Global.connect("game_over", self, "_game_over_event")

func _game_over_event():
	self.show()
