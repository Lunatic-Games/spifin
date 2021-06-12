extends Control




func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().change_scene("res://level/level.tscn")
