extends KinematicBody2D

var motion = Vector2()

var ACCELERATION = 60
var MAX_SPEED = 80
const FRICTION = 0.4
const GRAVITY = 10
const JUMP = 275
const AIR_FRICTION = 0.2
const UP = Vector2(0, -1)

func _physics_process(delta):
	var idle = false
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, - MAX_SPEED)
		
	if is_on_floor():
		motion.y = 0
			
		if not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			idle = true
			motion.x = lerp(motion.x, 0, FRICTION)	
	
		if Input.is_action_pressed("ui_up"):
			motion.y -= JUMP
			
	if not is_on_floor():
		if idle:
			motion.x = lerp(motion.x, 0, AIR_FRICTION)
	
	
	move_and_slide(motion, UP)
