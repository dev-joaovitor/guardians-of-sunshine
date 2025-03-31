extends CanvasLayer

@onready var death_timer: Timer = $DeathTimer

func _on_killzone_kill() -> void:
	show()
	death_timer.start()


func _on_death_timer_timeout() -> void:
	hide()
