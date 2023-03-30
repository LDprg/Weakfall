extends Node

@onready var manager = $"../.."

func _ready():
	manager.set_selected_node_path(get_parent().get_path())
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("click"):
			manager.set_selected_node_path(get_parent().get_path())
		elif event.is_action_pressed("shift_click"):			
			manager.add_selected_node_path(get_parent().get_path())
