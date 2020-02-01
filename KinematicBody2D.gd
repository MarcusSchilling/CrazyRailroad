extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 160 # Pixels/second

func _physics_process(_delta):
	var motion = Vector2()
	
	var slow = false
	if Input.is_action_pressed("ui_up"):
		if Input.is_action_pressed("ui_left"):
			motion = Vector2(-1, -1)
		elif Input.is_action_pressed("ui_right"):
			motion = Vector2(1, -1)
		else:
			motion = Vector2(0, -1)
			slow = true;
	elif Input.is_action_pressed("ui_down"):
		if Input.is_action_pressed("ui_left"):
			motion = Vector2(-1, 1)
		elif Input.is_action_pressed("ui_right"):
			motion = Vector2(1, 1)
		else:
			motion = Vector2(0,1)   
			slow = true 
	elif Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("ui_up"):
			motion = Vector2(-1, -1)
		elif Input.is_action_pressed("ui_down"):
			motion = Vector2(-1, 1)
		else:
			motion = Vector2(-1,0)  
	elif Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("ui_up"):
			motion = Vector2(1, -1)
		elif Input.is_action_pressed("ui_down"):
			motion = Vector2(1, 1)
		else:
			motion = Vector2(1,0)  
	#elif Input.is_action_pressed("ui_select"):
		#get_node("/root/main/GUI").addScrap()
		
	else:
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0
	
	if motion.y > 0 and motion.x > 0:
		$AnimatedSprite.play("Player_SE")
	elif motion.y > 0 and motion.x < 0:
		$AnimatedSprite.play("Player_SW")
	elif motion.y < 0 and motion.x > 0:
		$AnimatedSprite.play("Player_NE")
	elif motion.y < 0 and motion.x < 0:
		$AnimatedSprite.play("Player_NW")
	elif motion.x > 0:
		$AnimatedSprite.play("Player_E")
	elif motion.x < 0:
		$AnimatedSprite.play("Player_W")
	elif motion.y > 0:
		$AnimatedSprite.play("Player_S")
	elif motion.y < 0:
		$AnimatedSprite.play("Player_N")
	
	var speed
	if slow:
		speed = MOTION_SPEED / 2;
	else:
		speed = MOTION_SPEED    
	motion = ((motion * Vector2(1,0.6)).normalized()).normalized() * speed

	move_and_slide(motion)
