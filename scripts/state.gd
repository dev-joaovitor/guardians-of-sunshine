extends Node

signal update_score(new_score: int)
signal update_lives(new_lives_amount: int)
signal game_over
signal toggle_movement(val: bool)

var lives: int = 3
var score: int = 0
var is_game_over: bool = false

func kill_player() -> void:
	score = 0
	lives -= 1
	update_score.emit(score)
	update_lives.emit(lives)
	toggle_movement.emit(false)

func _on_killzone_kill() -> void:
	kill_player()

func _on_enemy_area_kill() -> void:
	kill_player()

func increment_score(val: int) -> void:
	score += val
	update_score.emit(score)

func _on_death_timer_timeout() -> void:
	if is_game_over:
		return

	if lives == -1:
		is_game_over = true
		game_over.emit()
		lives = 3
		update_lives.emit(lives)
		return
	toggle_movement.emit(true)

func _on_start_screen_start_game() -> void:
	is_game_over = false
	toggle_movement.emit(true)
