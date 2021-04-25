extends Node

signal score_updated(new_score)
signal time_updated(new_time)

var score := 0 setget set_score
var time := 300 setget set_time

func set_score(new_score: int):
	score = new_score
	emit_signal("score_updated", new_score)

func set_time(new_time: int):
	time = new_time
	emit_signal("time_updated", new_time)
