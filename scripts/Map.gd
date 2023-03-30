extends TileMap

const Const = preload("res://scripts/Constants.gd")

@onready var GameManager = $".."
@onready var Camera = $"../Player/Camera2D"

var action = false

func _input(event):
	if event is InputEventMouseMotion:
		var pos = local_to_map(to_local(Camera.get_real_mouse_position()))
		
		do_selection(pos)
		
		if action:
			do_action(pos)
	elif event.is_action_pressed("action"):
		if GameManager.getState() != Const.States.None:
			action = true
			do_action(local_to_map(to_local(Camera.get_real_mouse_position())))
	elif event.is_action_released("action"):
		action = false

func do_action(pos: Vector2):
	if GameManager.getState() == Const.States.Build:
		if get_cell_atlas_coords(0, pos) != Const.Tiles.Water and get_cell_atlas_coords(0, pos) != Const.Tiles.None:
			set_cell(1, pos, 0, Const.Tiles.Wall)
			_hide_changed(GameManager.getHidden())
	elif GameManager.getState() == Const.States.Delete:
		erase_cell(1, pos)
		
func do_selection(pos: Vector2):
	clear_layer(2)
	clear_layer(3)
	if GameManager.getState() == Const.States.Build:
		if get_cell_source_id(3, pos) != null:
			set_cell(3, pos, 0, Const.Tiles.Wall)
	elif GameManager.getState() == Const.States.Delete:
		if get_cell_source_id(2, pos) != null:
			set_cell(2, pos, 0, Const.Tiles.Selected)


func _hide_changed(hidden):
	if hidden:
		for cell in get_used_cells(1):
			if get_cell_atlas_coords(1, cell) == Const.Tiles.Wall:
				set_cell(1, cell, 0, Const.Tiles.Ground)
	else:
		for cell in get_used_cells(1):
			if get_cell_atlas_coords(1, cell) == Const.Tiles.Ground:
				set_cell(1, cell, 0, Const.Tiles.Wall)
