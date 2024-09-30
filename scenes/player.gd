extends CharacterBody2D

@export var speed := 300.0
@export var jump_speed := -2000.0
@export var gravity := 4000.0
@export var box : PackedScene

@onready var sprite = $PlayerSprite


func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func get_side_input():
	velocity.x = 0
	var vel := Input.get_axis("left", "right")
	var jump := Input.is_action_just_pressed("jump")

	if is_on_floor() and jump:		
		velocity.y = jump_speed
		get_tree().call_group("HUD", "updateScore")
		# cria uma caixa na posição do jogador
		var b := box.instantiate()
		b.position = global_position
		owner.add_child(b)
	velocity.x = vel * speed
	
func animate():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		
func animate_side():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		
func move_8way(delta):
	get_8way_input()
	animate()
	var collision_info : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		move_and_collide(velocity * delta * 10)
		
func move_side(delta):
	velocity.y += gravity * delta
	#print(velocity.y)
	get_side_input()
	animate_side()
	move_and_slide()

func _physics_process(delta):
	#move_8way(delta)
	move_side(delta)
