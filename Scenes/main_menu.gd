extends Control
var game_play_scene = "res://Scenes/GamePlay.tscn"
@onready var highscore_label: Label = %HighscoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	highscore_label.text = "Highscore: %s" %[str(HighscoreManager.highscore)]

func _on_play_button_pressed():
	get_tree().change_scene_to_file(game_play_scene)
