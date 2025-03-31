extends CanvasLayer

signal start_game

func _ready() -> void:
	show()

func _process(delta: float) -> void:
	if not visible:
		return

	if Input.is_action_just_pressed("start"):
		hide()
		start_game.emit()

func _on_state_game_over() -> void:
	show()
