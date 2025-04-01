extends CharacterBody2D

const HUNNY_BUNNY_POINTS = 800
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.animation = "none"

func _on_player_trigger_hunny_bunny_animation_body_entered(body: Node2D) -> void:
	animated_sprite.play("emerging")
	await animated_sprite.animation_finished
	animated_sprite.play("idle")
