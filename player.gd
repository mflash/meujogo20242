extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0

func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
#	var dx = Input.get_action_strength("right")-Input.get_action_strength("left")
#	var dy = Input.get_action_strength("down")-Input.get_action_strength("up")
#	var delta = Vector2(dx,dy)
#	print(delta)
	#print(input_direction)
	velocity = input_direction * speed
	
func get_rotation_input():
	rotation_direction = Input.get_axis("left", "right")
	#print("Direção: ",rotation_direction)
	velocity = transform.x * Input.get_axis("down", "up") * speed
	#print(transform.x)
	
func _physics_process(delta: float) -> void:
	# Descomente o bloco desejado de acordo com o tipo
	# de movimento:
	
	# 1. 8-way movement
	#get_8way_input()
	
	# 2. Rotation + movement
	get_rotation_input()
	rotation += rotation_direction * rotation_speed * delta
	
	move_and_slide()
