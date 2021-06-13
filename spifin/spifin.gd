extends KinematicBody2D


const MAX_SPEED = 150.0
const GRAVITY = 10.0
const ACCELERATION_WEIGHT = 0.8
const DECELERATION_WEIGHT = 0.5

export (bool) var dummy = false
export (bool) var sleeping = false


var velocity: Vector2
var disabled = false
var being_thrown = false
var jump_force = 150.0

func _ready():
	$Stretch/Sprite.material = $Stretch/Sprite.material.duplicate()
	if sleeping:
		go_to_sleep()


func _physics_process(_delta):
	if dummy:
		return
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
	elif not being_thrown:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION_WEIGHT)
	
	var snap = 2.0 * Vector2.DOWN if is_on_floor() else Vector2.ZERO
	var on_floor_before = is_on_floor()
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	if not on_floor_before and is_on_floor():
		$AnimationPlayer.play("land")


func go_to_sleep():
	$SleepParticles.emitting = true


func wake_up():
	$SleepParticles.emitting = false
