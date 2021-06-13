extends Control


var n_collected = 0

func _ready():
	$Label.text = ""
	$Label.visible = false
	
func shard_collected():
	n_collected += 1
	if n_collected == 8:
		$Label.text = "All shards collected!"
	elif n_collected == 7:
		$Label.text = str(8 - n_collected) + " shard remaining"
	else:
		$Label.text = str(8 - n_collected) + " shards remaining"
	$AnimationPlayer.play("display")
	yield(get_tree().create_timer(1.0), "timeout")
	open_doors()


func open_doors():
	get_tree().call_group("door", "check_status", n_collected)
