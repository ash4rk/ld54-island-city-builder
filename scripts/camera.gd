extends Camera

onready var Pivot = $"/root/Main/World/Pivot"

var PAN_SPEED = 15.0
var ORBIT_SPEED = 1

const ZOOM_SPEED = 3.0
const MAX_ZOOM = 55.0
const MIN_ZOOM = 17.0

const X_BOUNDARY = Vector2(-60.0, 50.0)
const Z_BOUNDARY = Vector2(-60.0, 50.0)

var panning:bool = false
var orbiting:bool = false

var mouse_pos: Vector2
var mouse_prev_pos = Vector2(0,0)
var mouse_delta: Vector2

func _ready():
	self.look_at(Pivot.global_transform.origin,Vector3(0,1,0))
	pass

func _process(delta):
	
#	self.look_at(Pivot.global_transform.origin,Vector3(0,1,0))
#	print(pivot_pos)
	
	mouse_pos = get_viewport().get_mouse_position()
	mouse_delta = mouse_pos - mouse_prev_pos
	
	
	if panning:
		if mouse_delta != Vector2(0,0):
#			print(mouse_delta)
			var pan_delta:Vector2 = (mouse_delta) * PAN_SPEED * delta
#			print(pan_delta)
			
			Pivot.movement(pan_delta, X_BOUNDARY, Z_BOUNDARY)
			self.look_at(Pivot.global_transform.origin,Vector3(0,1,0))
	
	if orbiting:
		if mouse_pos != mouse_prev_pos:
			var rot_delta = (mouse_pos - mouse_prev_pos) * ORBIT_SPEED * delta
			Pivot.rotate_y(rot_delta.x)	
	
	# end of _process
	mouse_prev_pos = mouse_pos
		

func _input(event):
	# start Panning
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT && event.pressed:
			panning = true
			
	# end Panning
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT && !event.pressed:
			panning = false
			
	# start Rotating
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE && event.pressed:
			orbiting = true
			
	# end Rotating
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_MIDDLE && !event.pressed:
			orbiting = false
	
	# zooming
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP and event.pressed and translation.y > MIN_ZOOM:
			_zoom(ZOOM_SPEED)
		if event.button_index == BUTTON_WHEEL_DOWN and event.pressed and translation.y < MAX_ZOOM:
			_zoom(-ZOOM_SPEED)

func _zoom(value):
	self.translate(Vector3(0.0, 0.0, -1.0 * value))
