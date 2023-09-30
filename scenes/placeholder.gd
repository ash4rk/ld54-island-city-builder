extends CSGBox

export(int, FLAGS, "Coastal", "OnTheRocks", "OnTheSand", "Forest") var terrain_tags = 0

enum State { NORMAL, ACTIVE, RESTRICTED }

var currentState: int = State.NORMAL

func _ready():
	update_mesh_color()
	$Area.connect("mouse_entered", self, "_on_area_mouse_entered")
	$Area.connect("mouse_exited", self, "_on_area_mouse_exited")

func _on_area_mouse_entered():
	match Global.want_to_build:
		"Sawmill":
			if terrain_tags == 8:
				change_state(State.ACTIVE)
			else:
				change_state(State.RESTRICTED)
		"Quarry":
			if terrain_tags == 2:
				change_state(State.ACTIVE)
			else:
				change_state(State.RESTRICTED)
		"Shipyard":
			if terrain_tags == 4:
				change_state(State.ACTIVE)
			else:
				change_state(State.RESTRICTED)
		"_":
			change_state(State.RESTRICTED)

func _on_area_mouse_exited():
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
	
	self.material.albedo_color = color

func _on_Area_input_event(camera, event, position, normal, shape_idx):
	if currentState != State.ACTIVE:
		return
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		match Global.want_to_build:
			"Sawmill":
				self.add_child(preload("res://scenes/sawmill.tscn").instance())
			"Quarry":
				self.add_child(preload("res://scenes/quarry.tscn").instance())
			"Shipyard":
				self.add_child(preload("res://scenes/shipyard.tscn").instance())
			"_":
				pass
