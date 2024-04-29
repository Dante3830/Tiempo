extends Node

@onready var result = $Result
@onready var hiScore = $HiScore

func _process(_delta):
	result.text = "Tu tiempo: " + str(Global.formatted_time)
	hiScore.text = str(Global.get_highest_score_secs()) + ":" + str(Global.get_highest_score_misecs())

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	Global.game_on = true
	Global.remaining_time = 30
	Global.lives = 3

func _on_quit_button_pressed():
	get_tree().quit()
