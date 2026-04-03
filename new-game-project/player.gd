extends CharacterBody2D

#signal hit

@export var speed: float = 200.0
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(1020, 585)
	screen_size = get_viewport_rect().size
	


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

	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed
		$AnimatedSprite2D.play("walk_left")
		$AnimatedSprite2D.flip_h = velocity.x > 0
		#$CollisionShape2D.flip_h = velocity.x > 0
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()
		
	#print(direction)

	move_and_slide()

	position = position.clamp(Vector2.ZERO, screen_size)

# Layers
# 0 = blue roof tiles
# 1 = big tree
# 2 = rock border tiles
# 3 = top water grass border
# 4 = grass left water right border
# 5 = grass right water left border
# 6 = grass top water bottom border
