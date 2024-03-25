extends Node2D

var direction = Vector2.RIGHT
var body_parts = []
var body_scene = preload("res://body_part.tscn")
var accumulated_time = 0.0
var tile_size = 0  
var head
var game

func _ready():
	game = $".."
	tile_size = game.tile_size
	for i in range(5):
		add_snake_tiles(Vector2((i * tile_size), tile_size))
	
func add_snake_tiles(position):
	var part = body_scene.instantiate() as Sprite2D
	var scale_factor = Vector2(tile_size,tile_size) / part.texture.get_size()
	part.scale = scale_factor
	add_child(part)
	part.position = position
	body_parts.append(part)
	head = body_parts[body_parts.size()-1]


func move(delta):
	accumulated_time += delta
	if accumulated_time >= game.game_speed * 0.2:
		for i in range(0,body_parts.size() - 2, 1):
			body_parts[i].position = body_parts[i + 1].position
		var head_old_position = head.position
		body_parts[body_parts.size()-1].position += direction * tile_size
		body_parts[body_parts.size()-2].position = head_old_position
		accumulated_time -= game.game_speed * 0.2
		
	  


func handle_input(event):
	match event.keycode:
		KEY_UP,KEY_W:
			direction = Vector2.UP if direction != Vector2.DOWN else direction
		KEY_DOWN, KEY_S:
			direction = Vector2.DOWN if direction != Vector2.UP else direction
		KEY_LEFT,KEY_A:
			direction = Vector2.LEFT if direction != Vector2.RIGHT else direction
		KEY_RIGHT,KEY_D:
			direction = Vector2.RIGHT if direction != Vector2.LEFT else direction

func grow():
	add_snake_tiles(head.position)

func collides_with_berry(berry):
	return head.position.distance_to(berry.position) < tile_size

func collides_with_self():
	for snake_tile_index in range(0,body_parts.size()-2,1):
		if head.position == body_parts[snake_tile_index].position:
			return true
	return false

func is_out_of_bounds():
	return head.position.x < 0 or head.position.y < 0 or head.position.x > get_viewport().size.x or head.position.y > get_viewport().size.y

