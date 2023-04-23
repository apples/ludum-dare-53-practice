extends Node2D
var block_scene = preload("res://Objects/Block/block.tscn")
var number_of_blocks: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	render_blocks()
	
func render_blocks():
	var block_position = Vector2(100, 0)
	var row_pattern = []
	for j in range(5):
		block_position.y += 50
		block_position.x = 100
		row_pattern = row_pattern()
		var row_pattern_reversed = row_pattern.duplicate()
		row_pattern_reversed.reverse()
		row_pattern.append_array(row_pattern_reversed)
		for i in range(10):
			var block: CharacterBody2D = block_scene.instantiate()
			block.set_position(block_position)
			if row_pattern[i]:
				self.add_child(block)
				number_of_blocks += 1
			block_position.x += 105

func row_pattern():
	var row_pattern = []
	for i in range(5):
		if coin_flip() == 1:
			row_pattern.push_back(true)
		else:
			row_pattern.push_back(false)
			
	if !row_pattern.has(true):
		return row_pattern()
	else:
		return row_pattern
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if number_of_blocks == 0:
		render_blocks()

func coin_flip():
	return randi_range(0, 1)


func _on_ball_block_destroyed():
	number_of_blocks -= 1
