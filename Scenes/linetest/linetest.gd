extends Node2D

@onready var cannon: Line2D = $Cannon
@onready var goblin = $Goblin
@onready var goblin_label = $Goblin/Label

var bullet_scene := preload("res://Scenes/linetest/high_velocity_armor_piercing_bullet.tscn")
const BULLET_SPEED := 20


func _process(delta):
	var target_pos := to_local(get_viewport().get_mouse_position())
	
	var start_pos := cannon.points[0]
	var difference := target_pos - start_pos
	var direction_to_target := difference.normalized()
	var distance := difference.length()
	
	cannon.points[1] = start_pos + direction_to_target
	goblin.position = target_pos
	
	var left_or_right := direction_to_target.dot(Vector2.RIGHT)
	
	if left_or_right < 0: # left
		cannon.gradient.colors[0] = Color.MAGENTA
		cannon.gradient.colors[1] = Color.YELLOW
	else: #right
		cannon.gradient.colors[0] = Color.GREEN
		cannon.gradient.colors[1] = Color.CORNFLOWER_BLUE
	
	goblin_label.text = "([color=#f44]%.1f[/color],[color=4f4]%.1f[/color])" % [difference.x, difference.y]


func _on_timer_timeout():
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.position = cannon.points[0]
	bullet.velocity = (cannon.points[1] - cannon.points[0]).normalized() * BULLET_SPEED
	add_child(bullet)
