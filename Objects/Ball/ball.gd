extends CharacterBody2D
signal block_destroyed()

const SPEED = 300

func _ready():
	# Refresh the seed.
	randomize()
	var directionX = randf_range(-1, 1)
	var directionY = 1 #randf_range(0.1, 1)
	var direction = Vector2(directionX, directionY)
	velocity = direction * SPEED
	$Sprite.play("idle")

func _physics_process(delta):
	move_and_slide()
	var lastSlideCollision = get_last_slide_collision()
	
	if lastSlideCollision:
		velocity = velocity.bounce(lastSlideCollision.get_normal())
		
		if lastSlideCollision.get_collider().name == "Paddle":
			var paddle: Node = lastSlideCollision.get_collider()
			if self.global_position.x < paddle.global_position.x:
				var ratio = paddle.global_position.x - self.global_position.x
				velocity.x = ratio * -8
			if self.global_position.x > paddle.global_position.x:
				var ratio = self.global_position.x - paddle.global_position.x
				velocity.x = ratio * 8
		if lastSlideCollision.get_collider().is_in_group("Blocks"):
			var block: Node = lastSlideCollision.get_collider()
			block.queue_free()
			block_destroyed.emit()
			# add points
		
