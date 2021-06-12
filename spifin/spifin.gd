extends KinematicBody2D


const MAX_SPEED = 150.0
const GRAVITY = 10.0
const ACCELERATION_WEIGHT = 0.8
const DECELERATION_WEIGHT = 0.5
const LAND_VELOCITY_THRESHOLD = 50.0

var velocity: Vector2
var disabled = false
var jump_force = 150.0

func _ready():
	$Sprite.material = $Sprite.material.duplicate()


func _physics_process(_delta):
	var movement = 0.0
	velocity.y += GRAVITY
	
	if Input.is_action_pressed("move_right") and not disabled:
		movement += 1
	if Input.is_action_pressed("move_left") and not disabled:
		movement -= 1
	
	if movement == 0.0 and is_on_floor():
		if $AnimationPlayer.current_animation == "move":
			$AnimationPlayer.play("reset_to_idle")
		else:
			$AnimationPlayer.queue("idle")
	else:
		if $AnimationPlayer.current_animation != "land" and is_on_floor():
			$AnimationPlayer.play("move")
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and not disabled:
		velocity.y = -jump_force
		$AnimationPlayer.play("jump")
	elif not is_on_floor():
		$AnimationPlayer.play("jump")
	
	if movement > 0.0:
		velocity.x = lerp(velocity.x, MAX_SPEED, ACCELERATION_WEIGHT)
	elif movement < 0.0:
		velocity.x = lerp(velocity.x, -MAX_SPEED, ACCELERATION_WEIGHT)
	elif not disabled:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION_WEIGHT)
	
	var on_floor_before = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	if not on_floor_before and is_on_floor():
		$AnimationPlayer.play("land")
