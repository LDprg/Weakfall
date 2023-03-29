extends TileMap

const Const = preload("res://scripts/Constants.gd")

@onready var GameManager = $".."
@onready var Camera = $"../Player/Camera2D"

func _input(event):
	if event is InputEventMouseMotion:
		if GameManager.getState() == Const.States.Build:
			var pos = local_to_map(to_local(Camera.get_real_mouse_position()))
			clear_layer(2)
			if get_cell_source_id(2, pos) != null:
				set_cell(2, pos, 0, Vector2i(2, 1))

