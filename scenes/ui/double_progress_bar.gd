tool
extends Control

export var value_name: String
export var value: int = 0 setget _set_value

onready var value_name_label: Label = $InfoPanel/VBoxContainer/ValueName
onready var value_label: Label = $InfoPanel/VBoxContainer/Value
onready var neg_progress = $HBoxContainer/NegativeProgress
onready var pos_progress = $HBoxContainer/PositiveProgress

func _ready():
	self.connect("mouse_entered", self, "_on_mouse_entered")
	self.connect("mouse_exited", self, "_on_mouse_exited")
	value_name_label.text = value_name

func _set_value(new_value):
	value = new_value
	_set_sign_and_color(value_label, value)
	
	if value > 0:
		neg_progress.value = 0
		pos_progress.value = abs(value)
	elif value < 0:
		pos_progress.value = 0
		neg_progress.value = abs(value)
	else:
		pos_progress.value = 0
		neg_progress.value = 0

func _on_mouse_entered():
	if !$InfoPanel.visible:
		$InfoPanel.show()

func _on_mouse_exited():
	if $InfoPanel.visible:
		$InfoPanel.hide()

func _set_sign_and_color(label: Label, value: int):
	var sign_char = ""
	if value > 0:
		sign_char = "+"
		label.modulate = Color.green
	elif value < 0:
		sign_char = "-"
		label.modulate = Color.red
	elif value == 0:
		sign_char = "+"
		label.modulate = Color.white
		
	label.text = sign_char+str(abs(value))
