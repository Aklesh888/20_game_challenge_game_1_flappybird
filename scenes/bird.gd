extends CharacterBody2D

var gravity = 2000
var jump_strength = 6000

func _physics_process(delta):
	await get_tree().create_timer(1).timeout
	rotate(get_angle_to(-velocity) + PI)
	velocity.y += gravity * delta
	if Input.is_action_pressed("jump"):
		velocity.y -= jump_strength * delta
	
	move_and_slide()
	clamp(velocity.y, -5000, 5000)
	

func hurt():
	get_tree().reload_current_scene()
