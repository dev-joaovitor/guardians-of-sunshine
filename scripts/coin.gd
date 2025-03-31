extends Area2D

const COIN_POINTS = 5

func _on_body_entered(body: Node2D) -> void:
		print("+1 coin")
		$CoinSprite.set_animation("collected")

func _process(delta: float) -> void:
	if $CoinSprite.get_animation() == "collected":
		if not $CoinSprite.is_playing():
			queue_free()
