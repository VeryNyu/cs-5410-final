extends Node

var DATA: Dictionary = {
	0: {
		"PlayerSpawnPoint": Vector2i(37, 201),
		"EnemySpawnPoints": [{
			"Type": "",
			"SpawnPoint": Vector2i()
		}]
	},
	1: {
		"PlayerSpawnPoint": Vector2i(26, 177),
		"EnemySpawnPoints": [{
			"Type": "",
			"SpawnPoint": Vector2i()
		}]
	},
	2: {
		"PlayerSpawnPoint": Vector2i(37, 101),
		"EnemySpawnPoints": [{
			"Type": "",
			"SpawnPoint": Vector2i()
		}]
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
