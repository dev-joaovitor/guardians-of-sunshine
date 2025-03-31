extends CanvasLayer

@onready var death_timer: Timer = $DeathTimer

func _on_killzone_kill() -> void:
	show()
	death_timer.start()

func _on_death_timer_timeout() -> void:
	hide()

func _on_state_update_lives(new_lives_amount: int) -> void:
	$Message.text = "GAME OVER" if new_lives_amount == -1 else "YOU LOSE"
