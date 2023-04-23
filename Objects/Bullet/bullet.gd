extends CharacterBody2D
const SPEED = 600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var directionX = randf_range(-0.2, 0.2)
	var directionY = -1
	var direction = Vector2(directionX, directionY)
	velocity = direction * SPEED

func _physics_process(_delta):
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Blocks"):
		body.hit()
		self.queue_free()

func _on_timer_timeout():
	self.queue_free()
