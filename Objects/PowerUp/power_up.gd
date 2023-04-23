extends CharacterBody2D
const SPEED = 300.0

func _ready():
	var directionX = 0
	var directionY = 1
	var direction = Vector2(directionX, directionY)
	velocity = direction * SPEED

func _physics_process(delta):
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "Paddle":
		self.queue_free()
