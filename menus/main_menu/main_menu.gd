extends Control




func _input(event):
	if event.is_action_pressed("jump"):
		$AnimationPlayer.play("fade_out")


func faded_out():
	var _ret = get_tree().change_scene("res://level/level.tscn")
