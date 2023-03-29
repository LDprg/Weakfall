extends Node

@export var CurrentState = States.None

@onready var StateLabel = $"../../UI/PanelContainer/MarginContainer/StateLabel"

signal stateChanged(state: States)

enum States {
	Build,
	Delete,
	Select,
	None
}

func _ready():
	setState(CurrentState)

func getStateText(state: States):
	var text = "ERROR"
	
	match state:
		States.Build: text = "Build"
		States.Delete: text = "Delete"
		States.Select: text = "Select"
		States.None: text = "None"
		
	return text

func setState(state: States):
	CurrentState = state	
	StateLabel.set("text", getStateText(state))
	stateChanged.emit(state)
	
func _input(event):
	if event.is_action_pressed("deselect"):
		setState(States.None)

func _on_walls_pressed():
	setState(States.Build)


func _on_remove_pressed():
	setState(States.Delete)
