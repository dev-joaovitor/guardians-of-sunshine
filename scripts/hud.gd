extends CanvasLayer

var current_lives: int = 3

@onready var lives: Node2D = $Lives

func _on_killzone_kill() -> void:
	var children := lives.get_children()
	
	current_lives -= 1
	
	if current_lives == -1:
		
		return get_tree().reload_current_scene()
	
	for c_idx in range(0,3):
		var child := children[c_idx]
		
		if c_idx >= current_lives:
			child.hide()
		else:
			child.show()


func _on_start_screen_start_game() -> void:
	current_lives = 3
	show()
