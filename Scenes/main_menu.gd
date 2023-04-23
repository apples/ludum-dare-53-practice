extends Control
var game_play_scene = "res://Scenes/GamePlay.tscn"
@onready var highscore_label: Label = %HighscoreLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	highscore_label.text = "Highscore: %s" %[str(HighscoreManager.highscore)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PlayButton.button_down
	pass

func _on_play_button_pressed():
	get_tree().change_scene_to_file(game_play_scene)
