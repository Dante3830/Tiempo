extends Area2D

var speed = 5000

func _physics_process(delta):
	position.x -= delta * speed

func _on_body_entered(body):
	if body.has_method("player_hit"):
		body.player_hit()
		queue_free()

func _on_despawner_timeout():
	queue_free()
