extends Area2D


onready var animation = get_node("AnimationPlayer")


func _on_coin_body_entered(_body: Node) -> void:
	animation.play("fadeOut")
