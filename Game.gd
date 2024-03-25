extends Node2D

var snake
var berry
var score = 0
var game_over = false
@export var tile_size = 30
@export var game_speed = 1

func _ready():
	set_process_input(true)
	snake = $Snake
	berry = $Berry
	spawn_berry()

func _process(delta):
	if game_over:
		return
	snake.move(delta)
	check_collisions()

func _input(event):
	if event is InputEventKey and event.pressed:
		snake.handle_input(event)

func check_collisions():
	if snake.collides_with_berry(berry):
		score += 1
		$Score.text = "Score: " + str(score)
		spawn_berry()
		snake.grow()
	elif snake.collides_with_self() or snake.is_out_of_bounds():
		end_game()

func spawn_berry():
	var max_x_position = get_viewport_rect().size.x / tile_size
	var max_y_position = get_viewport_rect().size.y / tile_size
	berry.position = Vector2(randf_range(1, max_x_position)*tile_size, randf_range(1, max_y_position)*tile_size)

func end_game():
	game_over = true
	Global.score = score
	if score > Global.max_score:
		Global.max_score = score
	get_tree().change_scene_to_file("res://main_menu.tscn")
