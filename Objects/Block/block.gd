extends CharacterBody2D
signal block_destroyed()

func hit():
	if $AnimatedBlock.frame == 0:
		$AnimatedBlock.frame += 1
	else:
		self.queue_free()
		block_destroyed.emit(self.get_position())
