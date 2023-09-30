extends Node

onready var build_buttons = $UI/BuildingContainer/HBoxContainer.get_children()
onready var cancel_build_button = $UI/CancelBuildButton
onready var build_placeholders = $World/Placeholders

enum State { NORMAL, BUILDING }

var currentState: int = State.NORMAL

func _ready():
	_init_build_buttons()

func _process(delta):
	match currentState:
		State.NORMAL:
			build_placeholders.visible = false
			cancel_build_button.visible = false
		State.BUILDING:
			build_placeholders.visible = true
			cancel_build_button.visible = true

func _init_build_buttons():
	for button in build_buttons:
		button.connect("pressed", self, "_on_build_button_pressed")
	cancel_build_button.connect("pressed", self, "_on_cancel_build_button_pressed")

func _on_build_button_pressed():
	currentState = State.BUILDING

func _on_cancel_build_button_pressed():
	currentState = State.NORMAL
