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


func _on_signal(key: String) -> void:
	print()
	
	match key:
		"Start":
			print("Menu Manager(Start) Reporting: " + key)
		"Level":
			print("Menu Manager(Level) Reporting: " + key)
		["One", "Two", "Three"]:
			Game_Start.emit(key)
		"Leaderboard": print("Menu Manager(Leaderboard) Reporting: " + key)
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
