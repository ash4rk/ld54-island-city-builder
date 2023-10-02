extends Spatial


func _ready():
	pass # Replace with function body.


func movement(trnslt:Vector2, x_bound:Vector2, z_bound:Vector2):
	
	var trnslt_value:Vector3 = Vector3(0,0,0)
	trnslt_value.x = -trnslt.x
	trnslt_value.z = -trnslt.y
	
	var planned_position:Vector3 = self.global_transform.origin + trnslt_value
	trnslt_value = planned_position - global_transform.origin
	
	self.translate_object_local(trnslt_value)
	self.global_transform.origin.x = clamp(self.global_transform.origin.x, x_bound.x, x_bound.y)
	self.global_transform.origin.z = clamp(self.global_transform.origin.z, z_bound.x, z_bound.y)
