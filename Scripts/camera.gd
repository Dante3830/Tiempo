extends Camera2D

@export_category("Follow Player")
@export var player : CharacterBody2D

@export_category("Camera Smoothing")
@export var smoothing : bool
@export_range(1, 10) var smoothing_distance : int = 8

func _physics_process(_delta):
	var weight : float
	
	if player != null:
		var camera_position : Vector2
		
		if smoothing:
			weight = float(15 - smoothing_distance) / 100
			camera_position.x = lerp(global_position.x, player.global_position.x, weight)
			camera_position.y = 300
		else:
			camera_position.x = player.global_position.x
			camera_position.y = 300
			
		global_position = camera_position.floor()
