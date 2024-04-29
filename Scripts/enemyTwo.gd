extends CharacterBody2D

const  gravity = 1500
const speed = 2

var Bullet = preload("res://Scenes/EnemyBullet1.tscn")
@onready var spawnPosition1 = $SpawnPosition1

var enemyHealth = 10
var canShoot = true
var player

@onready var despawner = $Despawner

func _on_detection_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _process(_delta):
	if player != null and global_position.distance_to(player.global_position) > 100:
		despawner.start()

func _physics_process(delta:float):
	enemy_gravity(delta)
	enemy_walk()
	move_and_slide()

func enemy_gravity(delta : float):
	velocity.y += gravity * delta

func enemy_walk():
	velocity.x -= speed

func _on_shoot_speed_timeout():
	canShoot = true
	if player != null:
		shoot()

func shoot():
	if Global.enemyLeftSide:
		var bullet = Bullet.instantiate()
		bullet.position = spawnPosition1.global_position
		get_parent().add_child(bullet)
	
	$ShootSpeed.start()
	canShoot = false

func enemy_hit():
	enemyHealth -= 1
	if enemyHealth <= 0:
		Global.remaining_time += 20
		queue_free()

func _on_despawner_timeout():
	queue_free()
