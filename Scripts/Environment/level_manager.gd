extends Control

signal Goal

var LEVELS: Dictionary
var current_level: Node2D


func _ready() -> void:
	hide()
	LEVELS = {
		"One": get_node("One"),
		"Two": get_node("Two"),
		"Three": get_node("Three")
	}
	SaveLoad.load_scores(LEVELS.size())
	for level in LEVELS.values(): level.collision_enabled = false
	current_level = LEVELS["One"]
	
	$One.collision_enabled = true		# INITIATING FOR TESTING. REMOVE WHEN DONE.

func change_level(key: String):
	show()
	if key == "": return
	current_level.visible = false
	current_level.collision_enabled = false
	current_level = LEVELS[key]
	current_level.visible = true
	current_level.collision_enabled = true
	
	match key:
		"One": print("Level Manager Reporting Level: " + key)
		"Two": print("Level Manager Reporting Level: " + key)
		"Three": print("Level Manager Reporting Level: " + key)


func _on_goal() -> void:
	Goal.emit()
