extends KinematicBody2D


const MAX_SPEED = 150.0
const GRAVITY = 10.0
const JUMP_FORCE = 150.0
const ACCELERATION_WEIGHT = 0.8
const DECELERATION_WEIGHT = 0.5
const LAND_VELOCITY_THRESHOLD = 50.0

const SMALL_SPIFIN = preload("res://spifin/small_spifin.tscn")

var velocity: Vector2
var disabled = false


func _ready():
	add_collision_exception_with($Trajectory/TestObject)


func _input(event):
	if event.is_action_pressed("throw") and not disabled:
		throw()


func _physics_process(delta):
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
		velocity.y = -JUMP_FORCE
		$AnimationPlayer.play("jump")
	elif not is_on_floor():
		$AnimationPlayer.play("jump")
	
	if movement > 0.0:
		velocity.x = lerp(velocity.x, MAX_SPEED, ACCELERATION_WEIGHT)
		#$Sprite.flip_h = true
	elif movement < 0.0:
		velocity.x = lerp(velocity.x, -MAX_SPEED, ACCELERATION_WEIGHT)
		#$Sprite.flip_h = false
	else:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION_WEIGHT)
	
	var on_floor_before = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	if not on_floor_before and is_on_floor():
		$AnimationPlayer.play("land")


func throw():
	$AnimationPlayer.play("throw")
	disabled = true
	$Trajectory.visible = false
	$Sprite/SmallSpifin.visible = false
	
	var smol_spifin = SMALL_SPIFIN.instance()
	smol_spifin.add_collision_exception_with(self)
	get_parent().add_child(smol_spifin)
	smol_spifin.global_position = $Sprite/SmallSpifin.global_position
	smol_spifin.throw($Trajectory.angle)
	
