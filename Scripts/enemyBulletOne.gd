extends Area2D

var speed = 1000
var player

func _on_detection_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _physics_process(delta):
	if !Global.enemyLeftSide:
		position.x += delta * speed
	elif Global.enemyLeftSide:
		position.x -= delta * speed

func _on_body_entered(body):
	if body.has_method("player_hit"):
		body.player_hit()
		queue_free()

func _on_despawner_timeout():
	queue_free()
