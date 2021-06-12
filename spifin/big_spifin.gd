extends "res://spifin/spifin.gd"

const SMALL_SPIFIN = preload("res://spifin/small_spifin.tscn")

func _ready():
	add_collision_exception_with($TrajectoryIndicator/TestObject)


func _input(event):
	if event.is_action_pressed("throw") and not disabled:
		throw()


func throw():
	$AnimationPlayer.play("throw")
	disabled = true
	$TrajectoryIndicator.visible = false
	$Stretch/Sprite/SmallSpifin.visible = false
	
	var smol_spifin = SMALL_SPIFIN.instance()
	smol_spifin.add_collision_exception_with(self)
	get_parent().add_child_below_node(self, smol_spifin)
	smol_spifin.global_position = $Stretch/Sprite/SmallSpifin.global_position
	smol_spifin.throw($TrajectoryIndicator.angle)
	$TrajectoryIndicator/TestObject.add_collision_exception_with(smol_spifin)
	$Camera2D.current = false
	
