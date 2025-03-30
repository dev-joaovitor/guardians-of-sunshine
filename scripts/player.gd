extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -150.0
var direction = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dancing_timer: Timer = $DancingTimer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 0.5 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get direction
	direction = Input.get_axis("move_left", "move_right")
	
	# Face to direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Show animation accordingly
	if is_on_floor():
		if direction == 0:
			# prevent idle animation to override dancing
			if not animated_sprite.animation == "dancing":
				if dancing_timer.is_stopped():
					dancing_timer.start()
				animated_sprite.play("idle")
		else:
			dancing_timer.stop()
			animated_sprite.play("walking")
	else:
		dancing_timer.stop()
		
		# prevent looping
		if not animated_sprite.animation == "jumping":
			animated_sprite.play("jumping")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_dancing_timer_timeout() -> void:
	animated_sprite.play("dancing")
