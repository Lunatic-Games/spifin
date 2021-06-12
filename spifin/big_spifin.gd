extends "res://spifin/spifin.gd"

const SMALL_SPIFIN = preload("res://spifin/small_spifin.tscn")
const AWAKE_TEXTURE = preload("res://assets/art/spifin/big_spifin.png")
const ASLEEP_TEXTURE = preload("res://assets/art/spifin/big_spifin_asleep.png")
const ASLEEP_SMALL_TEXTURE = preload("res://assets/art/spifin/small_smifin_asleep.png")
const AWAKE_SMALL_TEXTURE = preload("res://assets/art/spifin/small_smifin.png")

func _ready():
	add_collision_exception_with($TrajectoryIndicator/TestObject)
	
	if dummy:
		remove_child($TrajectoryIndicator)
		disabled = true
	else:
		$Camera2D.current = true


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
	

func small_spifin_returned():
	$Stretch/Sprite/SmallSpifin.visible = true
	$Camera2D.current = true
	disabled = false
	$TrajectoryIndicator.visible = true


func go_to_sleep():
	.go_to_sleep()
	$Stretch/Sprite.texture = ASLEEP_TEXTURE
	$Stretch/Sprite/SmallSpifin.texture = ASLEEP_SMALL_TEXTURE
	$Stretch/Sprite/SmallSpifin/SleepParticles.emitting = true


func wake_up():
	.wake_up()
	$Stretch/Sprite.texture = AWAKE_TEXTURE
	$Stretch/Sprite/SmallSpifin.texture = AWAKE_SMALL_TEXTURE
	$Stretch/Sprite/SmallSpifin/SleepParticles.emitting = false
