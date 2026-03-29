extends Control

signal Level_Selected
signal Change


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed(key: String) -> void:
	match key:
		"One", "Two", "Three":
			print("Level Select Sending Signal: " + key)
			Level_Selected.emit(key)
		"Back": Change.emit("Back")
