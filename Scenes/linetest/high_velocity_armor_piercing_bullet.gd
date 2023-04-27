extends Node2D

var velocity: Vector2

var _initial_position: Vector2

const MAX_TRAVEL := 20

func _ready():
	_initial_position = position

func _process(delta):
	position += velocity * delta
	if (position - _initial_position).length() > MAX_TRAVEL:
		queue_free()
