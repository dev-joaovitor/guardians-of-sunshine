extends CanvasLayer

@onready var lives: Node2D = $Lives

func _on_start_screen_start_game() -> void:
	show()

func _on_state_update_score(new_score: int) -> void:
	$Score.text = str(new_score)

func _on_state_update_lives(new_lives_amount: int) -> void:
	var children := lives.get_children()

	for c_idx in range(0, children.size()):
		var child := children[c_idx]
		
		if c_idx >= new_lives_amount:
			child.hide()
		else:
			child.show()
