extends Area2D

var listening = false

func _unhandled_input(event):
	if listening and event is InputEventKey and event.is_pressed():
		_on_Button_pressed()

func _on_Key_body_entered(_body):
	$WinScreen/Panel.show()
	$WinScreen/Panel/Rows/Score.text = "Score: " + str(Globals.score)
	$WinScreen/Panel/Rows/Time.text = "Time: " + str(Globals.time * 10)
	$WinScreen/Panel/Rows/Total.text = "TOTAL: " + str(Globals.score + Globals.time * 10)
	get_tree().paused = true
	$Win.play()
	yield(get_tree().create_timer(0.3), "timeout")
	listening = true


func _on_Button_pressed():
	get_tree().paused = false
	Globals.score = 0
	Globals.time = 300
	get_tree().change_scene("res://menu/Intro.tscn")
