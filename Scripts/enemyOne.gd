extends CharacterBody2D

var player
var enemyHealth = 3
var speed = 5
var canShoot = true
var Bullet = preload("res://Scenes/EnemyBullet1.tscn")
@onready var spawnPosition1 = $SpawnPosition1
@onready var despawner = $Despawner

func _on_detection_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _process(_delta):
	if player != null and global_position.distance_to(player.global_position) < 500:
		despawner.start()
	
	if player != null and player.global_position.x < global_position.x:
		Global.enemyLeftSide = true
	elif player != null and player.global_position.x > global_position.x:
		Global.enemyLeftSide = false
	

func _physics_process(_delta):
	var movement = Vector2.ZERO
	
	if player != null:
		movement = position.direction_to(player.position) * speed
	
	var collision = move_and_collide(movement)

func _on_shoot_speed_timeout():
	canShoot = true
	if player != null:
		shoot()

func shoot():
	var bullet = Bullet.instantiate()
	bullet.position = spawnPosition1.global_position
	get_parent().add_child(bullet)
	
	$ShootSpeed.start()
	canShoot = false

func enemy_hit():
	enemyHealth -= 1
	if enemyHealth <= 0:
		Global.remaining_time += 10
		queue_free()

func _on_despawner_timeout():
	queue_free()

