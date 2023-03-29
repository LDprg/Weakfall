extends Camera2D

@export_category("MoveableCamera2D")
@export var moveFactor = 1
@export var zoomFactor = 0.05
@export var minZoom = 1
@export var maxZoom = 40

var following = false

func _ready():
	position -= get_viewport_rect().size/2

func _input(event):
	if event.is_action_pressed("move_view"):
		following = true
	elif event.is_action_released("move_view"):
		following = false
	elif event is InputEventMouseMotion:	
		if following:
			position -= event.relative * moveFactor / zoom
	elif event.is_action("zoom_in"):
		if (zoom + Vector2.ONE * zoomFactor).length_squared() < maxZoom:
			zoom += Vector2.ONE * zoomFactor
	elif event.is_action("zoom_out"):
		if (zoom - Vector2.ONE * zoomFactor).length_squared() > minZoom:
			zoom -= Vector2.ONE * zoomFactor

func get_real_mouse_position():
	return get_mouse_position()/zoom + position

func get_mouse_position():
	return get_viewport().get_mouse_position()
