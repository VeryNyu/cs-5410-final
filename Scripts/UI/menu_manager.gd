extends Control

var STATES: Dictionary
var current_state: Node 


func _ready() -> void:
	STATES = {
		"Start": get_node("Start"),
		"Level": get_node("LevelSelect"),
		"Leaderboard": get_node("Leaderboard")
	}
	current_state = STATES["Start"]


func _on_signal(key: String) -> void:
	print()
	
	match key:
		"Start": print("Menu Manager(Start) Reporting: " + key)
		"Level": print("Menu Manager(Level) Reporting: " + key)
		"Leaderboard": print("Menu Manager(Leaderboard) Reporting: " + key)
		_: print("Menu Manager(Default) Reporting: " + key)
	
	_menu_change(key)


func _menu_change(key: String) -> void:
	current_state.visible = false
	current_state = STATES[key]
	current_state.visible = true
