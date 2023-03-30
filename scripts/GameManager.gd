extends Node

const Const = preload("res://scripts/Constants.gd")

@export var CurrentState = Const.States.None
@export var hidden = false

@onready var StateLabel = $"../../UI/PanelContainer/MarginContainer/StateLabel"
@onready var Camera = $Player/Camera2D

signal stateChanged(state: Const.States)
signal hideChanged(hide: bool)

var Selected : Array

func _ready():
	setState(CurrentState)
	
func getState():
	return CurrentState
	
func getHidden():
	return hidden

func getStateText(state: Const.States):
	var text = "ERROR"
	
	match state:
		Const.States.Build: text = "Build"
		Const.States.Delete: text = "Delete"
		Const.States.Select: text = "Select"
		Const.States.None: text = "None"
		
	return text

func setState(state: Const.States):
	CurrentState = state	
	StateLabel.set("text", getStateText(state))
	stateChanged.emit(state)
	
func _input(event):
	if event.is_action_pressed("deselect"):
		setState(Const.States.None)
		Selected.clear()
	elif event.is_action_pressed("action"):
		for path in Selected:
			get_node(path).set_target(Camera.get_real_mouse_position())
			

func set_selected_node_path(path):
	Selected.clear()
	Selected.append(path)
	
func add_selected_node_path(path):
	if not Selected.has(path):
		Selected.append(path)
		
func clear_selected_node_path():
	Selected.clear()

func _on_walls_pressed():
	setState(Const.States.Build)

func _on_remove_pressed():
	setState(Const.States.Delete)


func _on_hide_pressed():
	hidden = not hidden
	hideChanged.emit(hidden)
