extends CharacterBody2D

const SPEED := 130.0
const JUMP_VELOCITY := -150.0
const ATTACK_JUMP_VELOCITY := -75.0
const ATTACK_DASH_VELOCITY := 100.0
var direction := 0.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dancing_timer: Timer = $DancingTimer

var initial_position: Vector2
var is_punching: bool = false
var has_bouncy_bee_animation_triggered: bool = false
var can_move: bool = false

func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 0.5 * delta
	
	if not can_move:
		velocity.x = 0
		animated_sprite.animation = "dancing"
		return
	
	if is_punching:
		velocity.x = 0
		
		animated_sprite.play("punching")
		
		if animated_sprite.frame == 4:
			velocity.y = ATTACK_JUMP_VELOCITY
			velocity.x = (-1 if animated_sprite.flip_h else 1) * ATTACK_DASH_VELOCITY
		
		await animated_sprite.animation_finished
		
		is_punching = false
		return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("attack") and is_on_floor():
		print("attack")
		is_punching = true
	
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

func _on_dancing_timer_timeout() -> void:
	if is_punching:
		return
		
	animated_sprite.play("dancing")

func _on_state_toggle_movement(val: bool) -> void:
	can_move = val

func _on_bouncy_bee_toggle_animation(val: bool) -> void:
	can_move = not val

func _on_hunny_bunny_toggle_animation(val: bool) -> void:
	can_move = not val
