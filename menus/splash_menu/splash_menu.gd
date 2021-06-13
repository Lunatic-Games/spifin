extends Control


func _input(event):
	if event is InputEventKey and event.pressed:
		next()


func next():
	var _ret = get_tree().change_scene("res://menus/main_menu/main_menu.tscn")
