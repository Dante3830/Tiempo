extends Area2D

var speed = 1000

func _physics_process(delta):
	if !Global.leftSide:
		position.x += delta * speed
	elif Global.leftSide:
		position.x -= delta * speed

func _on_body_entered(body):
	if body.has_method("enemy_hit"):
		body.enemy_hit()
		queue_free()

func _on_despawner_timeout():
	queue_free()
