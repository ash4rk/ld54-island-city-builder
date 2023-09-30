extends CSGBox

export(int, FLAGS, "Coastal", "OnTheRocks", "OnTheSand", "Forest") var terrain_tags = 0

enum State { NORMAL, ACTIVE, RESTRICTED }

var currentState: int = State.NORMAL

func _ready():
	update_mesh_color()
	$Area.connect("mouse_entered", self, "_on_area_mouse_entered")
	$Area.connect("mouse_exited", self, "_on_area_mouse_exited")

func _on_area_mouse_entered():
	if !Global.is_builduing_allowed():
		change_state(State.ACTIVE)
	else:
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
			color = Color.white
		State.ACTIVE:
			color = Color.green
		State.RESTRICTED:
			color = Color.red
	
	self.material.albedo_color = color
