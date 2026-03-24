extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

var screen_size


func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.play("double_jump")
		velocity += get_gravity() * delta
	else:
		$AnimatedSprite2D.play("idle")

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			$AnimatedSprite2D.flip_h = false
		elif direction < 0:
			$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Clamp the position between top-left (0,0) and bottom-right (screen_size)
	position.x = clamp(position.x, 0, 3272)
	position.y = clamp(position.y, 0, screen_size.y)

	move_and_slide()
