extends Spatial


func _ready():
	pass # Replace with function body.


func movement(trnslt:Vector2, x_bound:Vector2, z_bound:Vector2):
	
	var trnslt_value:Vector3 = Vector3(0,0,0)
	trnslt_value.x = -trnslt.x
	trnslt_value.z = -trnslt.y
	
	var planned_position:Vector3 = self.global_transform.origin + trnslt_value
	planned_position.x = clamp(planned_position.x, x_bound.x, x_bound.y)
	planned_position.z = clamp(planned_position.z, z_bound.x, z_bound.y)
	trnslt_value = planned_position - global_transform.origin
	
	self.translate_object_local(trnslt_value)
	
#	clamp(trnslt.x, x_bound.x, x_bound.y)
