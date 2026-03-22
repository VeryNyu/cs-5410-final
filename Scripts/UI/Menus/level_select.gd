extends Control

signal Change


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed(key: String) -> void:
	match key:
		"One": print("Level Select (One) Reporting " + key)
		"Two": print("Level Select (Two) Reporting " + key)
		"Three": print("Level Select (Three) Reporting " + key)
		"Back": Change.emit("Start")
