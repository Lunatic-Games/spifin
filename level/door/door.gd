extends StaticBody2D


export (int) var num_shards_required = 1


func check_status(shards_collected):
	if shards_collected >= num_shards_required:
		$Fade.play("open")
		$Shake.play("open")
		$CollisionShape2D.set_deferred("disabled", true)
