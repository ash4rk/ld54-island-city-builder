extends Control

export(NodePath) var CAMERA_PATH 
onready var camera = get_node(CAMERA_PATH) 

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_OrbitSpeedSlider_value_changed(value):
	camera.ORBIT_SPEED = value

func _on_MovementSpeedSlider_value_changed(value):
	camera.PAN_SPEED = value

func _on_BackButton_pressed():
	self.hide()

func _input(event):
	if event.is_action_pressed("open_options"):
		self.visible = !self.visible

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()

func _on_Options_visibility_changed():
	$Panel/VBoxContainer/RestartButton.visible = Global.current_step > 1
