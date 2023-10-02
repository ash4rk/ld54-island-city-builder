extends Node2D

var maxX = 50
var step = 10
var yOffset = 100

func _draw():
	draw_line(Vector2(0, -yOffset), Vector2(0, 250), Color(0, 0, 0), 2)
	draw_line(Vector2(0, yOffset), Vector2(530, yOffset), Color(0, 0, 0), 2)

	_draw_figure(Global.history.income, Color.yellow)
	_draw_figure(Global.history.technologies, Color.blue)
	_draw_figure(Global.history.attractiveness, Color.red)
	
func _draw_figure(values: Array, color: Color):
	var prev_point = Vector2(0, yOffset - values[0] * 5)
	for i in range(1, values.size()):
		var x = i * step
		var y = yOffset - values[i] * 5
		var current_point = Vector2(x, y)
		draw_line(prev_point, current_point, color, 4)
		prev_point = current_point

func _input(event):
	if event is InputEventMouseButton and visible:
		if (event.button_index == BUTTON_LEFT) && event.pressed:
			get_parent().hide()
