extends CharacterBody2D
signal power_up_collected()
const SPEED = 150
var multi_sprite = preload("res://assets/power_up_multi.png")
var gun_sprite = preload("res://assets/power_up_exstend.png")
var power_type

func _ready():
	power_type = coin_flip()
	if power_type == 1:
		$PowerUpSprite.texture = multi_sprite
	else:
		$PowerUpSprite.texture = gun_sprite
		
	var directionX = 0
	var directionY = 1
	var direction = Vector2(directionX, directionY)
	velocity = direction * SPEED

func _physics_process(delta):
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "Paddle":
		power_up_collected.emit(self.get_position(), power_type)
		self.queue_free()

func coin_flip():
	return randi_range(0, 1)
