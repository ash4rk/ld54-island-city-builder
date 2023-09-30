extends CSGBox

export(int, FLAGS, "Coastal", "OnTheRocks", "OnTheSand", "Forest") var terrain_tags = 0
enum State { NORMAL, ACTIVE, RESTRICTED, CONSTRUCTED}

onready var buildings_node = $"../../Buildings"

var want_to_build = null
var is_constracted: bool = false
var currentState: int = State.NORMAL

func _ready():
	update_mesh_color()
	$Area.connect("mouse_entered", self, "_on_area_mouse_entered")
	$Area.connect("mouse_exited", self, "_on_area_mouse_exited")

func _on_area_mouse_entered():
	if currentState == State.CONSTRUCTED:
		return

	match want_to_build:
		"Sawmill":
			change_state(State.ACTIVE)
		"Quarry":
			change_state(State.ACTIVE)
		"Shipyard":
			change_state(State.ACTIVE)
		"_":
			change_state(State.RESTRICTED)

func _on_area_mouse_exited():
	if currentState == State.CONSTRUCTED:
		return
	change_state(State.NORMAL)

func change_state(new_state):
	if currentState != new_state:
		currentState = new_state
		update_mesh_color()

func update_mesh_color():
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
		
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		match want_to_build:
			"Sawmill":
				_create_building(preload("res://scenes/sawmill.tscn").instance())
			"Quarry":
				_create_building(preload("res://scenes/quarry.tscn").instance())
			"Shipyard":
				_create_building(preload("res://scenes/shipyard.tscn").instance())
			"_":
				pass
		change_state(State.CONSTRUCTED)

func update_visibility(building):
	if building is String:
		return

	var required_terrain_idx = building._bundled.names.find("required_terrain")
	var building_name_idx = building._bundled.names.find("build_name")
	var required_terrain = building._bundled.variants[required_terrain_idx]
	var build_name = building._bundled.variants[building_name_idx]
	self.visible = self.terrain_tags == required_terrain
	want_to_build = build_name

func _create_building(build_instance):
	buildings_node.add_child(build_instance)
	build_instance.transform = self.transform
	
