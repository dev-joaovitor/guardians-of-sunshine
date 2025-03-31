extends Area2D

signal kill

func _on_body_entered(body: Node2D) -> void:
	body.position = body.initial_position
	kill.emit()
