extends Node2D


func _ready():
	$Bubbles.emitting = true
	$CPUParticles2D.emitting = true


func _on_Timer_timeout():
	queue_free()
