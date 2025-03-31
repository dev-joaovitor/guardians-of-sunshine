extends Area2D

@onready var state: Node = %State

const COIN_POINTS = 5
var was_collected: bool = false

func _on_body_entered(body: Node2D) -> void:
	if was_collected:
		return

	$CoinSprite.set_animation("collected")
	was_collected = true
	state.increment_score(COIN_POINTS)

func _process(delta: float) -> void:
	if $CoinSprite.get_animation() == "collected":
		if not $CoinSprite.is_playing():
			queue_free()
