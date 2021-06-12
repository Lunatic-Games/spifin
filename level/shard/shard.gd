extends Area2D


func eaten():
	$Sprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
