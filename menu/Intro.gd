extends Node2D

var Next := preload("res://level/Level.tscn")
var step := -1

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed():
		$NextSound.play()
		if step == -1:
			$Label.text = "This was a normal day around the lake for Jules Beaverne.\n\n\n\n\nThat is, until...\nhe lost his house keys!"
		elif step == 0:
			$Label.text = "To get to the bottom of the lake, he built a wooden submarine.\nWill he find the keys before running out of air?"
			$Sprite.frame = 1
		elif step == 1:
			get_tree().change_scene_to(Next)
		step += 1
