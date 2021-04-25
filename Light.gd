extends Light2D


func _process(_delta):
	if visible and randi()%200 == 0:
		energy = 0
		yield(get_tree().create_timer(rand_range(0.05, 0.2)), "timeout")
		energy = 1
