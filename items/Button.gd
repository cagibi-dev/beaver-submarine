extends Area2D

signal pressed
signal released

func _on_Button_body_entered(_body):
	$Sprite.frame = 1
	$Light.show()
	$Switch.pitch_scale = 1.6
	$Switch.play()
	emit_signal("pressed")


func _on_Button_body_exited(_body):
	$Sprite.frame = 0
	$Light.hide()
	$Switch.pitch_scale = 1
	$Switch.play()
	emit_signal("released")
