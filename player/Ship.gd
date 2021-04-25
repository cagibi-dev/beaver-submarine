extends RigidBody2D


var ship_speed := 800.0
var vx := 0.0
var run_speed := 500.0
var jump_speed := 250.0
var Bullet = preload("res://player/Bullet.tscn")
onready var p := $Player
onready var helpers := [$ButtonLeft/Label, $ButtonRight/Label, $ButtonShootLeft/Label2, $ButtonShootRight/Label2, $ButtonSpecial/Label2, $Label]

func _ready():
	for h in helpers:
		h.hide()

func _physics_process(delta: float):
	vx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	p.apply_central_impulse(Vector2(vx * run_speed * delta, 0))
	if Input.is_action_just_pressed("ui_up"):
		p.apply_central_impulse(Vector2.UP * jump_speed)
		$Player/Jump.play()
	
	if $Player/Sprite.scale.x > 0 and vx < 0:
		$Player/Sprite.scale.x = -1
	elif $Player/Sprite.scale.x < 0 and vx > 0:
		$Player/Sprite.scale.x = 1
	
	# self-stabilize
	apply_central_impulse(Vector2(0, -position.y + 0.2 * position.x))
	add_torque(-1000*rotation)


func _process(_delta: float):
	if $Player/RayCast2D.is_colliding():
		if vx != 0:
			$Player/AnimationPlayer.current_animation = "run"
		else:
			$Player/AnimationPlayer.current_animation = "idle"
	else:
		if p.linear_velocity.y >= 0:
			$Player/AnimationPlayer.current_animation = "fall"
		else:
			$Player/AnimationPlayer.current_animation = "jump"

func _on_ButtonLeft_pressed():
	add_central_force(Vector2(-ship_speed, 0))
	$EngineRight.play()
	$RightCannon/SuperBubbles.emitting = true
	$TileMap/Anim.playback_speed = -2
	$LeftCannon/Spot.show()


func _on_ButtonLeft_released():
	add_central_force(Vector2(ship_speed, 0))
	$EngineRight.stop()
	$RightCannon/SuperBubbles.emitting = false
	$TileMap/Anim.playback_speed = 0.5
	$LeftCannon/Spot.hide()


func _on_ButtonRight_pressed():
	add_central_force(Vector2(ship_speed, 0))
	$EngineLeft.play()
	$LeftCannon/SuperBubbles.emitting = true
	$TileMap/Anim.playback_speed = 2
	$RightCannon/Spot.show()


func _on_ButtonRight_released():
	add_central_force(Vector2(-ship_speed, 0))
	$EngineLeft.stop()
	$LeftCannon/SuperBubbles.emitting = false
	$TileMap/Anim.playback_speed = 0.5
	$RightCannon/Spot.hide()


func _on_LeftShootTimer_timeout():
	$ShootLeft.play()
	var bullet = Bullet.instance()
	bullet.global_position = $LeftCannon.global_position
	bullet.velocity = linear_velocity - Vector2(200, 0).rotated(rotation)
	apply_central_impulse(Vector2(400, 0).rotated(rotation))
	get_parent().add_child(bullet)


func _on_RightShootTimer_timeout():
	$ShootRight.play()
	var bullet = Bullet.instance()
	bullet.global_position = $RightCannon.global_position
	bullet.velocity = linear_velocity + Vector2(200, 0).rotated(rotation)
	apply_central_impulse(Vector2(-400, 0).rotated(rotation))
	get_parent().add_child(bullet)


func _on_ButtonShootLeft_pressed():
	$LeftShootTimer.start()

func _on_ButtonShootLeft_released():
	$LeftShootTimer.stop()

func _on_ButtonShootRight_pressed():
	$RightShootTimer.start()

func _on_ButtonShootRight_released():
	$RightShootTimer.stop()

func _on_ButtonSpecial_pressed():
	for h in helpers:
		h.show()
	$LeftCannon/Spot.show()
	$RightCannon/Spot.show()

func _on_ButtonSpecial_released():
	for h in helpers:
		h.hide()
	$LeftCannon/Spot.hide()
	$RightCannon/Spot.hide()
