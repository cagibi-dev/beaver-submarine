extends RigidBody2D


export (NodePath) var target := ".."
var Explosion := preload("res://items/FishExplosion.tscn")
var target_node: Node2D

func _physics_process(delta):
	if not target_node:
		target_node = get_node_or_null(target)
	if target_node:
		apply_central_impulse(delta * (target_node.global_position - global_position))

func _process(_delta):
	$Sprite.scale.x = sign(linear_velocity.x)


func _on_HitBox_area_entered(_area):
	Globals.set_score(Globals.score + 100)
	var ex = Explosion.instance()
	ex.position = position
	get_parent().add_child(ex)
	queue_free()
