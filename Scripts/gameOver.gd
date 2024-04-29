extends Node

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	Global.game_on = true
	Global.remaining_time = 30
	Global.lives = 3
