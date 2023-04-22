extends Node2D
var block_scene = preload("res://Objects/Block/block.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var block: CharacterBody2D = block_scene.instantiate()
	var block_position = Vector2(50, 50)
	block.set_position(block_position)
	self.add_child(block)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
