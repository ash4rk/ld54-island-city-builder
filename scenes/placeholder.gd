extends CSGBox

signal building_created()
export(int, FLAGS, "Coastal", "Mountains", "Ground") var terrain_tags = 0
enum State { NORMAL, ACTIVE, RESTRICTED, CONSTRUCTED}

onready var buildings_node = $"../../"

var want_to_build_info = null
var cost_value = 0
var currentState: int = State.NORMAL

func _ready():
	_update_mesh_color()
	$Area.connect("mouse_entered", self, "_on_area_mouse_entered")
	$Area.connect("mouse_exited", self, "_on_area_mouse_exited")

func _on_area_mouse_entered():
	if currentState == State.CONSTRUCTED:
		return

	if want_to_build_info.build_name == "_":
		change_state(State.RESTRICTED)
	else:
		change_state(State.ACTIVE)

func _on_area_mouse_exited():
	if currentState == State.CONSTRUCTED:
		return
	change_state(State.NORMAL)

func change_state(new_state):
	if currentState != new_state:
		currentState = new_state
		_update_mesh_color()

func _update_mesh_color():
	var color
	match currentState:
		State.NORMAL:
			color = Color(1.0, 1.0, 1.0, 0.4)
		State.ACTIVE:
			color = Color(0.0, 1.0, 0.0, 0.4)
		State.RESTRICTED:
			color = Color(1.0, 0.0, 0.0, 0.4)
		State.CONSTRUCTED:
			color = Color(1.0, 0.0, 0.0, 0.4)
	
	self.material.albedo_color = color

func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if currentState != State.ACTIVE:
		return
		
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT) and Global.coins>= cost_value:
		match want_to_build_info.build_name:
			"Docks":
				_create_building(preload("res://scenes/docks.tscn").instance())
			"Bungalow":
				_create_building(preload("res://scenes/bungalow.tscn").instance())
			"Hotel":
				_create_building(preload("res://scenes/hotel.tscn").instance())
			"Factory":
				_create_building(preload("res://scenes/factory.tscn").instance())
			"CatAttraction":
				_create_building(preload("res://scenes/cat_attraction.tscn").instance())
			"Spaceport":
				_create_building(preload("res://scenes/spaceport.tscn").instance())
			"Meteo":
				_create_building(preload("res://scenes/meteo.tscn").instance())
			"Winery":
				_create_building(preload("res://scenes/winery.tscn").instance())
			"_":
				pass
		change_state(State.CONSTRUCTED)
		emit_signal("building_created")
		Global.coins -= cost_value
		Global.income += want_to_build_info.income
		Global.next_move()

func update_visibility(building_info):
	if building_info is String:
		return

	cost_value = building_info.cost_coins
	want_to_build_info = building_info
	self.visible = self.terrain_tags == building_info.required_terrain

func _create_building(build_instance):
	buildings_node.add_child(build_instance)
	build_instance.transform = self.transform
