extends CharacterBody2D
var base_paddle = preload("res://assets/Paddle .png")
var gun = preload("res://assets/gun_up.png")

const SPEED = 600.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_game_play_gun_power_up_collected():
	$GunUpSprite.visible = true
