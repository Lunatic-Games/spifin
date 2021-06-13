extends Sprite


func begin(player):
	player.disabled = true
	for shard in $Spin.get_children():
		shard.come_down()
	$AnimationPlayer.play("spin")
	yield($AnimationPlayer, "animation_finished")
	get_tree().call_group("outro_player", "play", "outro")
	yield(get_tree().create_timer(1.0), "timeout")
	$AnimationPlayer.play("float")
