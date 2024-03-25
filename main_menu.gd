extends Control

func _ready():
	$MarginContainer/VBoxContainer/Score.text = "Your score is: " + str(Global.score)
	$"MarginContainer/VBoxContainer/Max Score".text = "Your max score is: " + str(Global.max_score)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
