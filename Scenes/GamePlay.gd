extends Node2D
signal gun_power_up_collected()
@onready var lives_label: Label = %LivesLabel
@onready var score_label: Label = %ScoreLabel
var balls: Array[CharacterBody2D]
var ball_scene = preload("res://Objects/Ball/ball.tscn")
var block_scene = preload("res://Objects/Block/block.tscn")
var power_up_scene = preload("res://Objects/PowerUp/power_up.tscn")
var number_of_blocks: int = 0
var lives: int = 3
var score: int = 0
var total_balls: int = 0
var main_menu_scene = "res://Scenes/main_menu.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	load_level()
	
func render_blocks():
	var block_position = Vector2(100, 0)
	var row_pattern = []
	for j in range(5):
		block_position.y += 50
		block_position.x = 100
		row_pattern = create_row_pattern()
		var row_pattern_reversed = row_pattern.duplicate()
		row_pattern_reversed.reverse()
		row_pattern.append_array(row_pattern_reversed)
		for i in range(10):
			if row_pattern[i]:
				var block: CharacterBody2D = block_scene.instantiate()
				block.block_destroyed.connect(_on_block_destroyed)
				block.armor_hit.connect(_on_block_armor_hit)
				block.set_position(block_position)
				$BlockContainer.add_child(block)
				number_of_blocks += 1
			block_position.x += 105

func create_row_pattern():
	var row_pattern = []
	for i in range(5):
		if coin_flip() == 1:
			row_pattern.push_back(true)
		else:
			row_pattern.push_back(false)
			
	if !row_pattern.has(true):
		return create_row_pattern()
	else:
		return row_pattern
		
func reset_ball():
	var new_ball = ball_scene.instantiate()
	balls.append(new_ball)
	var ball_pos = Vector2(600, 300)
	new_ball.set_position(ball_pos)
	self.call_deferred("add_child", new_ball)
	total_balls = 0
	total_balls += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if number_of_blocks == 0:
		for ball in balls:
			ball.queue_free()
		
		balls = []
		load_level()
		
func load_level():
	render_blocks()
	reset_ball()

func coin_flip():
	return randi_range(0, 1)

func _on_block_armor_hit():
	$BlockHitSFX.play()
	
	
func _on_block_destroyed(block_pos):
	$BlockDeathSFX.play()
	number_of_blocks -= 1
	score += 50
	score_label.text = "Score: %s" %[str(score)]
	var chance_drop = randi_range(0, 2)
	if chance_drop == 2:
		var power_up: CharacterBody2D = power_up_scene.instantiate()
		power_up.power_up_collected.connect(_on_power_up_collected)
		power_up.set_position(block_pos)
		self.call_deferred("add_child", power_up)

func _on_death_plane_body_entered(body):
	if body.is_in_group("Balls"):
		total_balls -= 1
		if total_balls == 0:
			lives -= 1
			if lives == 0:
				get_tree().change_scene_to_file(main_menu_scene)
				if score > HighscoreManager.highscore:
					HighscoreManager.highscore = score
			else:
				lives_label.text = "Lives: %s" %[str(lives)]
				reset_ball()

func _on_power_up_collected(power_up_pos, power_type):
	$PowerUpGainSFX.play()
	if power_type == 1:
		multi_power_up(power_up_pos)
	else:
		gun_power_up_collected.emit()
	
func multi_power_up(power_up_pos):
	var extra_ball = ball_scene.instantiate()
	balls.append(extra_ball)
	extra_ball.from_power_up = true
	var ball_pos = power_up_pos
	ball_pos.y -= 15
	extra_ball.set_position(ball_pos)
	self.call_deferred("add_child", extra_ball)
	total_balls += 1
