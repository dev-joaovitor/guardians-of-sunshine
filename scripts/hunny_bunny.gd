extends Node2D

signal toggle_animation(val: bool)

const HUNNY_BUNNY_POINTS = 800
var has_animation_run: bool = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.animation = "none"

func _on_player_trigger_hunny_bunny_animation_body_entered(body: Node2D) -> void:
	if has_animation_run:
		return

	animated_sprite.play("emerging")
	toggle_animation.emit(true)
	await animated_sprite.animation_finished
	animated_sprite.play("idle")
	toggle_animation.emit(false)
	has_animation_run = true

func _on_enemy_area_got_killed() -> void:
	$EnemyArea.queue_free()
	animated_sprite.animation = "dying"
	%State.increment_score(HUNNY_BUNNY_POINTS)
