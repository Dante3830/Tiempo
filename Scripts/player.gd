extends CharacterBody2D

const speed = 300.0
const jump_force = -800.0
@onready var animationPlayer = $AnimatedSprite2D
var playerBullet = preload("res://Scenes/PlayerBullet.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum state {idle, up, down, shoot}
var currentState = state.idle

const playerInitialPosition := Vector2i(571, 433)

@onready var BulletSpawn1 = $BulletSpawn1
@onready var BulletSpawn2 = $BulletSpawn2

func _ready():
	position = playerInitialPosition

func _physics_process(delta):
	if Input.is_action_just_pressed("Left"):
		animationPlayer.flip_h = true
	elif Input.is_action_just_pressed("Right"):
		animationPlayer.flip_h = false
	
	if Input.is_action_just_pressed("Down"):
		currentState = state.down
	
	if Input.is_action_just_pressed("Restart"):
		Global.lives -= 1
	
	if Input.is_action_just_pressed("Fire"):
		var bullet = playerBullet.instantiate()
		
		if !animationPlayer.flip_h:
			Global.leftSide = false
			bullet.position = BulletSpawn1.global_position
			get_tree().current_scene.add_child(bullet)
		elif animationPlayer.flip_h:
			Global.leftSide = true
			bullet.position = BulletSpawn2.global_position
			get_tree().current_scene.add_child(bullet)
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_force
	
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	update_animation()
	move_and_slide()
	
	update_position()

func update_animation():
	if velocity.x != 0:
		animationPlayer.play("walk")
	else:
		animationPlayer.play("idle")
		$Collision2.hide()
	
	if currentState == state.down:
		animationPlayer.play("crouch")
		$Collision1.hide()
	
	if currentState == state.shoot:
		animationPlayer.play("idle shoot")
	
	if velocity.y < 0 or velocity.y > 0:
		animationPlayer.play("jump")

func update_position():
	if Global.remaining_time <= 0 or Input.is_action_just_pressed("Restart"):
		position = playerInitialPosition

func player_hit():
	Global.remaining_time -= 5
	print("PLAYER HIT")
