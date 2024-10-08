extends Node2D

const SPEED : int = 100

var total : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready!")
	update_score(total)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(delta)
	total += delta
	update_score(total)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		position.x += SPEED * delta # pixels/segundo
	
func _input(event: InputEvent) -> void:
	print(event.as_text())
	#if event.is_action_pressed("ui_right"):
	#	print("Right arrow!")
	
func update_score(current_score: float) -> void:
	$Score.text = str(current_score)
