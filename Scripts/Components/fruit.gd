extends Area2D

signal collect

var body: String = "apple"
var value: int = 100


func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		$CollisionShape2D.set_deferred("disabled", true)
		$Timer.stop()
		$AnimatedSprite2D.play("collect")
		collect.emit(value)
		await get_tree().create_timer(1.0).timeout
		queue_free()


func _on_timeout() -> void:
	$AnimatedSprite2D.play(body)
