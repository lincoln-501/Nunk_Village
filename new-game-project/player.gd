extends CharacterBody2D

#signal hit

@export var speed: float = 200.0
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(100, 100)
	$AnimatedSprite2D.play("walk")
	screen_size = get_viewport_rect().size
	#hide()


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	# Normalize to prevent faster diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
		$AnimatedSprite2D.play()
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()

	# Apply movement + collisions
	move_and_slide()

	# Animation control
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = velocity.y > 0
