extends KinematicBody2D


const GRAVITY = 10.0
const SPEED = 400.0

var velocity: Vector2

func throw(angle):
	velocity = Vector2(cos(angle), sin(angle)) * SPEED
	$Camera2D.current = true


func _physics_process(delta):
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		$ThrowCollision.set_deferred("disabled", true)
		$CollisionShape2D.set_deferred("disabled", false)
		velocity.x = 0.0
