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
		"One": get_tree().get_node("res://Scenes/Components/camera.tscn").limit_right = 3485
		"Two": get_tree().get_node("res://Scenes/Components/camera.tscn").limit_right = 3072
		"Three": get_tree().get_node("res://Scenes/Components/camera.tscn").limit_right = 2560


func _on_goal() -> void:
	Goal.emit()
