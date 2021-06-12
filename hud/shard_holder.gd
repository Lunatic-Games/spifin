extends TextureRect


var n_collected = 0

func shard_collected():
	visible = true
	n_collected += 1
	var shard = get_node("Shard" + str(n_collected))
	shard.visible = true
	$Tween.interpolate_property(shard, "rect_scale", Vector2(3.0, 3.0), Vector2(1.0, 1.0), 0.2)
	$Tween.start()
