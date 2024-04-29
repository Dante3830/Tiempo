extends Node

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	Global.game_on = true

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
