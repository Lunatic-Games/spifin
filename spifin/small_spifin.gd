extends "res://spifin/spifin.gd"


const THROW_SPEED = 400.0


func _ready():
	disabled = true
	jump_force = 250.0

func throw(angle):
	velocity = Vector2(cos(angle), sin(angle)) * THROW_SPEED

func _physics_process(delta):
	if is_on_floor():
		$ThrowCollisionShape.set_deferred("disabled", true)
		$CollisionShape2D.set_deferred("disabled", false)
		velocity.x = 0.0
		disabled = false
