extends Node

var game_on = false
var lives = 3
var initial_time = 30
var remaining_time = initial_time
var formatted_time

var high_score_secs = 0
var high_score_misecs = 0

var leftSide = false
var enemyLeftSide = true

var Seconds
var Milliseconds

func _process(delta):
	if game_on:
		remaining_time -= delta
		if remaining_time < 0:
			remaining_time = 0
		
		Seconds = int(remaining_time)
		Milliseconds = int((remaining_time - Seconds) * 1000)
		
		Milliseconds = int(round(Milliseconds / 10.0))
		
		if Seconds < 10 and Milliseconds < 10:
			formatted_time = "0" + str(Seconds) + ":" + "0" + str(Milliseconds)
		elif Seconds < 10:
			formatted_time = "0" + str(Seconds) + ":" + str(Milliseconds)
		elif Milliseconds < 10:
			formatted_time = str(Seconds) + ":" + "0" + str(Milliseconds)
		else:
			formatted_time = str(Seconds) + ":" + str(Milliseconds)
		
		if remaining_time <= 0:
			lives -= 1
			remaining_time = 30
		
		if lives == 0:
			get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
			game_on = false
		
	

func add_score(seconds, milliseconds):
	if seconds > high_score_secs:
		high_score_secs = seconds
	
	if milliseconds > high_score_misecs:
		high_score_misecs = milliseconds

func get_highest_score_secs():
	return high_score_secs

func get_highest_score_misecs():
	return high_score_misecs
