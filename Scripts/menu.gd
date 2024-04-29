extends Node

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	Global.game_on = true

func _on_htp_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/HowToPlay.tscn")
