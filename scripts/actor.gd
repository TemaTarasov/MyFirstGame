extends KinematicBody2D


class_name Actor

const FLOOR_NORMAL = Vector2.UP

export var speed: = Vector2(900.0, 1550.0)

export var gravity: = 5000.0

var _velocity: = Vector2.ZERO

func getGravity(velocity: Vector2) -> Vector2:
	velocity.y += gravity * get_physics_process_delta_time()
	
	return velocity
