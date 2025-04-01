extends Area2D

signal kill
signal got_killed

func _on_body_entered(body: Node2D) -> void:
	if body.is_punching:
		got_killed.emit()
		return

	body.position = body.initial_position
	kill.emit()
