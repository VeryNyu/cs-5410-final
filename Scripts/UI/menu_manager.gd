extends Control

signal Game_Start

var STATES: Dictionary
var current_state: Node
var last_state: Node
var paused: bool = false


func _ready() -> void:
	STATES = {
		"Start": get_node("Start"),
		"Level": get_node("LevelSelect"),
		"Leaderboard": get_node("Leaderboard"),
		"Pause": get_node("Pause")
	}
	current_state = STATES["Start"]
	last_state = STATES["Start"]


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if paused: $Pause.hide()
		else: _menu_change("Pause")
		paused = not paused
		get_tree().paused = paused


func _on_signal_change(key: String) -> void:
	print()
	
	match key:
		"Start":
			print(current_state.name + "-> Start Reporting: " + key)
		"Level":
			print(current_state.name + "-> Level Reporting: " + key)
		"Leaderboard": print(current_state.name + "-> Leaderboard Reporting: " + key)
		"Back": key = last_state.name
		_: print("Menu Manager(Default) Reporting: " + key)
	
	_menu_change(key)

func _on_game_start(key: String) -> void:
	print(key + " Signal Reached Manager, Forwarding to UI")
	Game_Start.emit(key)
	$Pause.level = key
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
	$LevelManager.change_level(key)
