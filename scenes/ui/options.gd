extends Control

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_OrbitSpeedSlider_value_changed(value):
	pass # Replace with function body.

func _on_MovementSpeedSlider_value_changed(value):
	pass # Replace with function body.

func _on_BackButton_pressed():
	self.hide()
