extends CharacterBody2D


const SPEED = 300.0

func _ready():
	# Refresh the seed.
	randomize()
	var directionX = randf_range(-1, 1)
	var directionY = randf_range(0.1, 1)
	var direction = Vector2(directionX, directionY)
	velocity = direction * SPEED

func _physics_process(delta):
	move_and_slide()
	var lastSlideCollision = get_last_slide_collision()
	
	if lastSlideCollision:
		velocity = velocity.bounce(lastSlideCollision.get_normal())
		
