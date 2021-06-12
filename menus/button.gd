extends Button


func _ready():
	rect_pivot_offset = rect_size / 2



func _on_mouse_entered():
	$AnimationPlayer.play("hover")


func _on_mouse_exited():
	$AnimationPlayer.play("unhover")
