extends Camera

const MOVEMENT_SPEED = 20.0 
const ZOOM_SPEED = 7.0
const MAX_ZOOM = 55.0
const MIN_ZOOM = 15.0

const X_BOUNDARY = Vector2(-100.0, 80.0)
const Z_BOUNDARY = Vector2(-30.0, 100.0)

var velocity = 2.0

var panning = false
var pan_start = Vector2()

func _process(delta):
	if panning:
		var mouse_pos = get_viewport().get_mouse_position()
		var pan_delta = (mouse_pos - pan_start) * MOVEMENT_SPEED * delta
		pan_start = mouse_pos
		var new_camera_position = Vector2(translation.x, translation.z) - pan_delta
		
		translation.x = clamp(new_camera_position.x, X_BOUNDARY.x, X_BOUNDARY.y)
		translation.z = clamp(new_camera_position.y, Z_BOUNDARY.x, Z_BOUNDARY.y)

func _input(event):
	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_MIDDLE or event.button_index == BUTTON_RIGHT) && event.pressed:
			panning = true
			pan_start = get_viewport().get_mouse_position()

	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_MIDDLE or event.button_index == BUTTON_RIGHT) && !event.pressed:
			panning = false

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP and event.pressed and translation.y < MAX_ZOOM:
			_zoom(-ZOOM_SPEED)
		if event.button_index == BUTTON_WHEEL_DOWN and event.pressed and translation.y > MIN_ZOOM:
			_zoom(ZOOM_SPEED)

func _zoom(value):
	self.translate(Vector3(0.0, 0.0, -1.0 * value))
