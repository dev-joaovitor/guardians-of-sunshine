extends Node

signal update_score(new_score: int)
signal update_lives(new_lives_amount: int)
signal game_over

var lives: int = 3
var score: int = 0
var is_dead: bool = false

func kill_player() -> void:
	score = 0
	lives -= 1
	update_score.emit(score)
	update_lives.emit(lives)

func _on_killzone_kill() -> void:
	kill_player()

func _on_enemy_area_kill() -> void:
	kill_player()

func increment_score(val: int) -> void:
	score += val
	update_score.emit(score)

func _on_death_timer_timeout() -> void:
	if lives == -1:
		game_over.emit()
		lives = 3
		update_lives.emit(lives)
