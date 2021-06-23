extends ColorRect


var time = 0.0


func _input(event):
	if event.is_action_pressed("jump") or event.is_action_pressed("ui_cancel"):
		if $Text.visible and visible:
			var _ret = get_tree().change_scene("res://menus/main_menu/main_menu.tscn")


func _process(delta):
	time += delta


func start_time():
	time = 0.0


func end_time():
	var minutes = 0.0
	while time > 60.0:
		time -= 60.0
		minutes += 1.0
	$Text/Time.text = "Time: " + str(int(minutes)) + "M " + str(int(time)) + "S"


func _on_End_body_entered(body):
	if not body.is_in_group("big_spifin"):
		return
	end_time()
