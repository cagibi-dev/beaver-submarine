extends Area2D

var velocity := Vector2()

func _physics_process(delta: float):
	position += velocity * delta
	$Sprite.rotation += 10 * delta

func _on_Timer_timeout():
	queue_free()
