extends CharacterBody2D
signal block_destroyed()
signal armor_hit()

func hit():
	if $AnimatedBlock.frame == 0:
		$AnimatedBlock.frame += 1
		armor_hit.emit()
	else:
		self.queue_free()
		block_destroyed.emit(self.get_position())
