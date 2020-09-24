extends KinematicBody2D

var motion = Vector2()

export var ACCELERATION = 200
export var MAX_SPEED = 250
export var FRICTION = 0.4
export var GRAVITY = 50
export var JUMP = 1000
export var AIR_FRICTION = 0.2
const UP = Vector2(0, -1)

func _physics_process(delta):
	var idle = false
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		
	if Input.is_action_pressed("left"):
		motion.x = max(motion.x - ACCELERATION, - MAX_SPEED)
		
	if is_on_floor():
		motion.y = 0
			
		if not Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
			idle = true
			motion.x = lerp(motion.x, 0, FRICTION)	
	
		if Input.is_action_pressed("jump"):
			motion.y -= JUMP
			
	if not is_on_floor():
		if idle:
			motion.x = lerp(motion.x, 0, AIR_FRICTION)
	
	
	motion = move_and_slide(motion, UP)
