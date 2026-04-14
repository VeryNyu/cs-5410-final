extends Area2D

signal collect

var body: String = "apple"
var value: int = 100


func _on_body_entered(_body: Node2D) -> void:
	$AnimatedSprite2D.animation.play("collect")
	collect.emit(value)
	get_tree().create_timer(1.0)
	queue_free()


func _on_timeout() -> void:
	$AnimatedSprite2D.animation.play(body)
