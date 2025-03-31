extends CanvasLayer

signal start_game

func _ready() -> void:
	show()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		hide()
		start_game.emit()
