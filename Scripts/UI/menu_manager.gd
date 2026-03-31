extends Control

signal Game_Start
signal Game_Quit

var STATES: Dictionary
var current_state: Control
var last_state: Control
var paused: bool


func _ready() -> void:
	STATES = {
		"Start": get_node("Start"),
		"Level": get_node("LevelSelect"),
		"Leaderboard": get_node("Leaderboard"),
		"Pause": get_node("Pause")
	}
	current_state = STATES["Start"]
	last_state = STATES["Start"]
	pause(false)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and current_state.visible == false:
		pause(true)

func pause(state: bool):
	if state: _menu_change("Pause")
	else: $Pause.hide()
	paused = state
	get_tree().paused = state


func _on_signal_change(key: String) -> void:
	print()
	
	match key:
		"Continue":
			get_tree().paused = false
			current_state.visible = false
			return
		"Start": Game_Quit.emit()
		"Level":
			print(current_state.name + " -> Level Reporting: " + key)
		"Leaderboard": $Leaderboard.display()
		"Back": key = last_state.name
		_: print("Menu Manager(Default) Reporting: " + key)
	
	_menu_change(key)


func _on_game_start(key: String) -> void:
	print(key + " Signal Reached Manager, Forwarding to UI")
	Game_Start.emit(key)
	current_state.visible = false


func _menu_change(key: String) -> void:
	last_state = current_state
	
	current_state.visible = false
	current_state = STATES[key]
	current_state.visible = true


func _on_level_selected(key: String) -> void:
	print("Menu Manager(Number) Reporting: " + key)
	current_state.visible = false
	Game_Start.emit(key)
