extends Actor


export var impulse: = 1000.0

onready var animation: = $AnimationPlayer


func _on_enemyDetector_area_entered(_area: Area2D) -> void:
	_velocity.y = -impulse


func _on_enemyDetector_body_entered(_body: Node) -> void:
	get_tree().reload_current_scene()


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()

	var isJumpInterrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = getDirection()

	_velocity = move_and_slide(
		calculteMoveVelocity(_velocity, direction, speed, isJumpInterrupted),
		FLOOR_NORMAL
	)

	if direction.x != 0.0 and is_on_floor() and !is_on_wall():
		animation.play("running_left" if direction.x == -1.0 else "running_right")
	else:
		yield(animation, 'animation_finished')
		animation.play("idle")


func getDirection() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculteMoveVelocity(
	velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	isJumpInterrupted: bool
) -> Vector2:
	velocity.x = speed.x * direction.x

	velocity = getGravity(velocity)

	if direction.y == -1.0:
		velocity.y = speed.y * direction.y

	if isJumpInterrupted:
		velocity.y = 0.0

	return velocity
