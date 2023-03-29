extends Node

const Const = preload("res://scripts/Constants.gd")

@export var CurrentState = Const.States.None

@onready var StateLabel = $"../../UI/PanelContainer/MarginContainer/StateLabel"

signal stateChanged(state: Const.States)

func _ready():
	setState(CurrentState)
	
func getState():
	return CurrentState

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

func _on_walls_pressed():
	setState(Const.States.Build)


func _on_remove_pressed():
	setState(Const.States.Delete)
