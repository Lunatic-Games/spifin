extends Line2D


export (float) var gravity = 15.0
export (float) var min_velocity = 400.0
export (float) var max_velocity = 1200.0


func _ready():
	clear_points()


func _physics_process(delta):
	var diff = get_global_mouse_position() - global_position
	var ratio = clamp(diff.length() / 400.0, 0.0, 1.0)
	var speed = (max_velocity - min_velocity) * ratio + min_velocity
	var rot = diff.angle()
	$TestObject.position = Vector2(0, 0)
	add_point($TestObject.position)
	var velocity = Vector2(cos(rot), sin(rot)) * speed
	
	clear_points()
	for i in range(100):
		velocity.y += gravity
		velocity = $TestObject.move_and_slide(velocity)
		add_point($TestObject.global_position - get_parent().global_position)
		if $TestObject.get_slide_count():
			$Crosshair.position = $TestObject.global_position - get_parent().global_position
			break
