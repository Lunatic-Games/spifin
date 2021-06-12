extends "res://spifin/spifin.gd"


const THROW_SPEED = 400.0

var held_shard: Area2D
var parent_spifin: KinematicBody2D


func _ready():
	disabled = true
	jump_force = 250.0
	$ShardLight.visible = false


func throw(angle):
	being_thrown = true
	velocity = Vector2(cos(angle), sin(angle)) * THROW_SPEED


func _physics_process(_delta):
	if is_on_floor():
		if being_thrown:
			$ThrowCollisionShape.set_deferred("disabled", true)
			$CollisionShape2D.set_deferred("disabled", false)
			velocity.x = 0.0
			disabled = false
			being_thrown = false
		else:
			for node in $DetectionArea.get_overlapping_areas():
				if node.is_in_group("shard"):
					eat_shard(node)
					break
				elif node.get_parent().is_in_group("big_spifin") and not disabled:
					if held_shard:
						spit_shard_out(node.get_parent())
					else:
						jump_on(node.get_parent())


func eat_shard(shard):
	disabled = true
	$AnimationPlayer.play("eat")
	held_shard = shard


func spit_shard_out(big_spifin):
	disabled = true
	$AnimationPlayer.play("spit_out")
	$AnimationPlayer.queue("jump_on")
	held_shard = null
	parent_spifin = big_spifin


func jump_on(big_spifin):
	disabled = true
	$AnimationPlayer.play("jump_on")
	parent_spifin = big_spifin


func jumped_back_on():
	call_deferred("queue_free")
	parent_spifin.small_spifin_returned()


func chomp_shard():
	held_shard.eaten()


func done_eating():
	disabled = false
