extends CharacterBody2D
var base_paddle = preload("res://assets/Paddle .png")
var gun = preload("res://assets/gun_up.png")
#var bullet = preload("res://assets/shoot.png")
const SPEED = 600.0
var gun_on = false
var bullet_scene = preload("res://Objects/Bullet/bullet.tscn")

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_game_play_gun_power_up_collected():
	if !gun_on:
		gun_on = true
		$GunUpSprite.visible = true
		$GunPowerUpTimer.start()
		$BulletInterval.start()
	else:
		$GunPowerUpTimer.start()

func _on_timer_timeout():
	$GunUpSprite.visible = false
	$BulletInterval.stop()
	gun_on = false

func _on_bullet_interval_timeout():
	var new_bullet = bullet_scene.instantiate()
	var bullet_pos = self.get_position()
	bullet_pos.y -= 50
	new_bullet.set_position(bullet_pos)
	self.get_parent().add_child(new_bullet)
