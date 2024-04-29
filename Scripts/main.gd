extends Node

@onready var camera = $Camera
var Enemy1 = preload("res://Scenes/Enemy1.tscn")
var Enemy2 = preload("res://Scenes/Enemy2.tscn")
var margin = 50

func _process(_delta):
	$CanvasLayer/Control/TimeDP.text = str(Global.formatted_time)
	$CanvasLayer/Control/LIVES/LivesDP.text = str(Global.lives)

func _on_exit_body_entered(body):
	if body.is_in_group("Player"):
		Global.game_on = false
		get_tree().change_scene_to_file("res://Scenes/Victory.tscn")
		Global.add_score(Global.Seconds, Global.Milliseconds)

func _on_enemy_spawn_1_timeout():
	var enemy = Enemy1.instantiate()
	
	var viewportSize = get_viewport().get_visible_rect().size
	
	var spawnX = randi_range(camera.position.x + viewportSize.x / 2, camera.position.x + viewportSize.x) + margin
	var spawnY = randi_range(0, viewportSize.y)
	
	enemy.position = Vector2(spawnX, spawnY)
	add_child(enemy)

func _on_enemy_spawn_2_timeout():
	var enemy = Enemy2.instantiate()
	
	var viewportSize = get_viewport().get_visible_rect().size
	
	var spawnX = randi_range(camera.position.x + viewportSize.x / 2, camera.position.x + viewportSize.x) + margin
	var spawnY = 433
	
	enemy.position = Vector2(spawnX, spawnY)
	add_child(enemy)
