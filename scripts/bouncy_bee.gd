extends Node2D

signal toggle_animation(val: bool)

const BOUNCY_BEE_POINTS = 500
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_idle: bool = true
var has_animation_ran: bool = false

func _physics_process(delta: float) -> void:
	if is_idle:
		return

	position.x += -1

func _on_trigger_animation_body_entered(body: Node2D) -> void:
	if has_animation_ran:
		return

	is_idle = false
	animated_sprite.animation = "walking"
	toggle_animation.emit(true)

func _on_enemy_area_got_killed() -> void:
	$EnemyArea.queue_free()
	animated_sprite.animation = "dying"
	%State.increment_score(BOUNCY_BEE_POINTS)

func _on_enemy_trigger_animation_area_entered(area: Area2D) -> void:
	if has_animation_ran:
		return

	has_animation_ran = true
	is_idle = true
	animated_sprite.animation = "idle"
	toggle_animation.emit(false)
