extends RigidBody2D

const MAX_DASH_TIME = 0.2
const MAX_DASH_VELOCITY = 1000
const DASH_ACCEL = 5000
const DASH_COOLDOWN = 1

const MAX_SUPER_VELOCITY = 2000
const SUPER_ACCEL = 5000

const MAX_BOUNCE_TIME = 0.1
const MAX_JUMP_TIME = 0.1
const MAX_VELOCITY = 200

const MOVE_ACCEL = 50
const MOVE_AIR_ACCEL = 25

# Control jump
var onFloor = false
var jumping = true
var jumpTime = 0

# Control dash
var dashing = false
var dashTime = 0
var dashTimeCooldown = 0
var dashReady = true


# Direction player is facing
var faceLeft = false
var faceRight = true

# Properties
var isPlayer = true
var isDead = false
var isIcy = false
var isSpeed = false
var isBounce = false


# Called when the node enters the scene tree for the first time.
func _ready():
	alive()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func alive():
	isDead = false
	self.lock_rotation = true
	$CollisionShape2D.disabled = false
	$DeadShape.disabled = true
	$Label.visible = false
	self.physics_material_override.bounce = 0
	self.physics_material_override.friction = 0
	print("alive")

func die():
	isDead = true
	self.lock_rotation = false
	$CollisionShape2D.disabled = true
	$DeadShape.disabled = false
	$Label.visible = true
	$AnimatedSprite2D.play("Dead")
	self.apply_torque_impulse(200)
	self.physics_material_override.bounce = 0.8
	self.physics_material_override.friction = 0.1
	self.apply_impulse(Vector2(0,-500))
	
	print("dead")

func _integrate_forces(s):
	# Physics
	var lv = s.get_linear_velocity()
	var step = s.get_step()
	
	# Get keyboard inputs
	var moveLeft = Input.is_action_pressed("move_left")
	var moveRight = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	var dash = Input.is_action_pressed("dash")
	var interact = Input.is_action_pressed("interact")
	
	if isDead and interact:
		alive()
		get_tree().reload_current_scene()
		
		
	
	if dash and dashReady and not dashing and not isDead:
		dashing = true
		dashReady = false
		dashTimeCooldown = 0
		if faceLeft:
			lv.x -= DASH_ACCEL
		if faceRight:
			lv.x += DASH_ACCEL
		
	if dashTime > MAX_DASH_TIME:
		dashing = false
		dashTime = 0
	elif dashing:
		dashTime += step
			
	if dashTimeCooldown > DASH_COOLDOWN and dashReady == false:
		dashTimeCooldown = 0
		dashReady = true
	else:
		dashTimeCooldown += step
	
	# Detect if colliding with a floor below player
	for x in get_colliding_bodies():
		if x.isSpikes and not isDead:
			die()
		elif x.isFloor:
			if x.isIcy:
				self.isIcy = true
			else:
				self.isIcy = false
			if x.isSpeed:
				self.isSpeed = true
			else:
				self.isSpeed = false
			if x.isBounce:
				self.isBounce = true
				#self.physics_material_override.bounce = 0.8
			else:
				self.isBounce = false
				self.physics_material_override.bounce = 0
			if lv.y == 0 and x.position.y > position.y:
				onFloor = true
			if lv.y > 0:
				onFloor = false
		
			
	if isDead:
		$AnimatedSprite2D.play("Dead")
	elif dash and lv.x != 0:
		$AnimatedSprite2D.play("SpeedWalk")	
	elif lv.y > 0 or lv.y < 0:
		$AnimatedSprite2D.play("Jump")		
	elif onFloor and not moveRight and not moveLeft:#lv.x == 0 and lv.y == 0:
		$AnimatedSprite2D.play("Stand")
	elif onFloor and lv.x != 0 and isSpeed:
		$AnimatedSprite2D.play("SpeedWalk")	
	elif onFloor and lv.x != 0:
		$AnimatedSprite2D.play("Walk")
	
			
	# Jump timer lets player jump different heights
	if onFloor:
		jumping = false
		jumpTime = 0
	else:
		jumpTime += step
			
	# Start a jump only on floor
	if onFloor:
		if jump and not jumping and not isDead:
			jumping = true
			onFloor = false
	
	# If player is not moving, slow player down
	if onFloor and not isIcy:		
		if not moveLeft and not moveRight:
			self.physics_material_override.friction = 1
	
	#if isBounce:
		#self.physics_material_override.bounce = 1.5
	#else:
		#self.physics_material_override.bounce = 0
			
	
	# Velocity up if jumping
	if jump and jumpTime < MAX_JUMP_TIME and not isBounce:
		lv.y -= 100
		jumping = true
		#self.physics_material_override.bounce = 0
	elif jump and jumpTime < MAX_BOUNCE_TIME and isBounce:
		lv.y -= 150
		jumping = true
		#self.physics_material_override.bounce = 0.8
	else:
		jumping = false
	
	# Move player left		
	if moveLeft and not moveRight and not dashing and not isDead:
		self.physics_material_override.friction = 0
		faceLeft = true
		faceRight = false
		$AnimatedSprite2D.flip_h = true
		if onFloor:
			lv.x -= MOVE_ACCEL
		else:
			lv.x -= MOVE_AIR_ACCEL
			
	# Move player right
	if moveRight and not moveLeft and not dashing and not isDead:
		self.physics_material_override.friction = 0
		faceLeft = false
		faceRight = true
		$AnimatedSprite2D.flip_h = false
		if onFloor:
			lv.x += MOVE_ACCEL
		else:
			lv.x += MOVE_AIR_ACCEL

	if dashing and not isDead and not isSpeed:
		self.physics_material_override.friction = 0
		lv.x = clamp(lv.x, -MAX_DASH_VELOCITY, MAX_DASH_VELOCITY)
		lv.y = 0
	elif isSpeed and not isDead:
		self.physics_material_override.friction = 0
		lv.x = clamp(lv.x, -MAX_SUPER_VELOCITY, MAX_SUPER_VELOCITY)
		if onFloor:
			$Camera2D.zoom = Vector2(1.5,1.5)
		else:
			$Camera2D.zoom = Vector2(2.0,2.0)
	else:
		lv.x = clamp(lv.x, -MAX_VELOCITY, MAX_VELOCITY)
		$Camera2D.zoom = Vector2(2.0,2.0)
		
	if not isDead:
		s.set_linear_velocity(lv)
