extends KinematicBody2D

var velocity = Vector2()
export var speed = 250


func _physics_process(delta):
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized()
	
	if Input.is_action_just_pressed("shoot"):
		# Shoot a weapon
		pass
	
	move_and_slide(velocity * speed)


func _on_area_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()
		get_tree().reload_current_scene()
