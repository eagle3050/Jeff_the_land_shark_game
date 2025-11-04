extends CharacterBody2D


var speed = 400.0
var jump_height = -500.0
var can_shark_mode = true
var in_shark_mode = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_height
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
	if Input.is_action_just_pressed("shark_mode") and can_shark_mode:
		enter_shark_mode()
	elif in_shark_mode and Input.is_action_just_pressed("shark_mode") or Input.is_action_just_pressed("jump") and not can_shark_mode:
		exit_shark_mode()
	
	
func enter_shark_mode():
	can_shark_mode = false
	in_shark_mode = true
	speed = 800
	scale.y = 0.2
	await get_tree().create_timer(3.5).timeout
	exit_shark_mode()
	
func exit_shark_mode():
	position.y += 50
	in_shark_mode = false
	can_shark_mode = true
	speed = 500
	scale.y = 1.0
