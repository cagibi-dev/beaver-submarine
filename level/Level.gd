extends Node2D

var gameover_listening = false

func _ready():
	Globals.connect("score_updated", self, "_on_score_updated")
	Globals.connect("time_updated", self, "_on_time_updated")

func _unhandled_input(event):
	if gameover_listening and event is InputEventKey and event.is_pressed():
		get_tree().paused = false
		pause_mode = Node.PAUSE_MODE_INHERIT
		gameover_listening = false
		Globals.score = 0
		Globals.time = 300
		get_tree().reload_current_scene()

func _on_score_updated(new_score: int):
	$HUD/Score.text = "Score: " + str(new_score)

func _on_time_updated(new_time: int):
	$HUD/Time.text = "Time: " + str(new_time)

func _process(_delta):
	$Camera2D.position = ($Ship.position + $Ship/Player.global_position) / 2

	# progression
	$Vignette/Sprite.modulate.a = clamp($Camera2D.position.y / 1000.0, 0.0, 1.0)
	$CanvasModulate.color = lerp(Color("#abc"), Color("#123"), $Camera2D.position.y / 4000.0)
	$HUD/Indicator.position.y = $Ship.position.y * (700.0 / 4000.0)


func _on_TimeTimer_timeout():
	Globals.time -= 1
	if Globals.time < 0:
		$HUD/GameOver/Sound.play()
		$Music.stop()
		$HUD/GameOver.show()
		pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused = true
		yield(get_tree().create_timer(0.3), "timeout")
		gameover_listening = true
		$HUD/Time/TimeTimer.stop()


func _on_Pause_pressed():
	get_tree().paused = not get_tree().paused

