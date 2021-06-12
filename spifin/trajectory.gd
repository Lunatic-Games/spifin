extends Line2D


export (float) var gravity = 10.0
export (float) var speed = 400.0

var angle = 0.0


func _ready():
	clear_points()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _physics_process(delta):
	var diff = get_global_mouse_position() - global_position
	angle = diff.angle()
	$Mouse.global_position = get_viewport().get_mouse_position()
	$Mouse.rotation = angle + PI / 2.0
	
	var velocity = Vector2(cos(angle), sin(angle)) * speed
	clear_points()
	$TestObject.position = Vector2(0, 0)
	add_point($TestObject.position)
	
	for i in range(100):
		velocity.y += gravity
		velocity = $TestObject.move_and_slide(velocity)
		add_point($TestObject.global_position - global_position)
		if $TestObject.get_slide_count():
			$Crosshair.global_position = $TestObject.global_position
			break
