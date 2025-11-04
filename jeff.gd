extends CharacterBody2D


var speed = 300.0
var jump_height = -500.0
var can_shark_mode = true
var in_shark_mode = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
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
	
func jump():
	velocity.y = jump_height
	
func enter_shark_mode():
	can_shark_mode = false
	in_shark_mode = true
	speed = 800
	scale.y = 0.2
	$SharkModeDur.start()
	
	
func exit_shark_mode():
	jump()
	in_shark_mode = false
	can_shark_mode = true
	speed = 500
	scale.y = 1.0


func _on_shark_mode_dur_timeout() -> void:
	exit_shark_mode()
