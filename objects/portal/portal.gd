tool

extends Area2D

onready var animation: AnimationPlayer = $AnimationPlayer

export var nextScene: PackedScene


func _on_portal_body_entered(_body: Node) -> void:
	teleport()


func _get_configuration_warning() -> String:
	return "The nextScene property can't be empty" if not nextScene else ""


func teleport() -> void:
	animation.play("fadeIn")

	yield(animation, 'animation_finished')

	get_tree().change_scene_to(nextScene)
