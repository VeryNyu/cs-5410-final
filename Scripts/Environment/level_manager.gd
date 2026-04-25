extends Control

signal Goal

var CAMERA: Node2D

var LEVELS: Dictionary
var current_level: Node2D


func _ready() -> void:
	#CAMERA = get_node("res://Scenes/Components/camera.tscn")
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
	CAMERA = get_node("../Player/Camera")
	if key == "": return
	current_level.visible = false
	current_level.collision_enabled = false
	current_level = LEVELS[key]
	current_level.visible = true
	current_level.collision_enabled = true
	$Three/Bridge.collision_enabled = false
	$Three/Startpoint/CollisionShape2D.disabled = true
	
	match key:
		"One": CAMERA.limit_right = 3485
		"Two": CAMERA.limit_right = 3072
		"Three":
			CAMERA.limit_right = 2560
			$Three/Bridge.collision_enabled = true
			$Three/Startpoint/CollisionShape2D.disabled = false


func _on_goal() -> void:
	Goal.emit()
