extends Control

var LEVELS: Dictionary
var current_level: Node2D


func _ready() -> void:
	LEVELS = {
		"One": get_node("One"),
		"Two": get_node("Two"),
		"Three": get_node("Three")
	}
	
	current_level = LEVELS["Three"]

func change_level(key: String):
	current_level.visible = false
	current_level = LEVELS[key]
	current_level.visible = true
	
	match key:
		"One": print("Level Manager Reporting Level: " + key)
		"Two": print("Level Manager Reporting Level: " + key)
		"Three": print("Level Manager Reporting Level: " + key)
