extends Node2D

@export var player: CharacterBody2D

@onready var brick: PackedScene = preload("res://assets/brick.tscn")
@onready var ball: PackedScene = preload("res://assets/ball.tscn")
@onready var brick_spawn_start: Marker2D = %brick_spawn_start
@onready var ball_spawn: Marker2D = $ball_spawn
@onready var ui: Control = $UI
@onready var ready_timer: Timer = $ReadyTimer
@onready var area_bounds: Area2D = $AreaBounds
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var audio_ball_missed: AudioStreamPlayer = $AudioBallMissed

var brick_rows: int = 4
var brick_col: int = 12
var brick_col_spacing: int = 78
var brick_row_spacing: int = 22

var brick_colors:Array[Color] = [
	Color.CRIMSON,
	Color.ORANGE,
	Color.WEB_GREEN,
	Color.YELLOW	
]

# arranged starting from top row, highest bricks increase speed the most
var speed_modifiers:Array[float] = [1.4, 1.3, 1.2, 1.0]


func _ready() -> void:
	_build_brick_grid()
	get_ready()
	ui.connect("win", _on_win)
	music_player.play()
	
	
func get_ready() -> void:
	ready_timer.start()
	if ui.has_method("ui_get_ready"):
		ui.ui_get_ready()	
	
	
func _spawn_ball() -> void:
	if ui.has_method("ui_game_ip"):
		ui.ui_game_ip()
	var ball_instance = ball.instantiate()
	add_child(ball_instance)
	ball_instance.global_position = ball_spawn.position
	ball_instance.hit_brick.connect(_increment_score)
	ball_instance.connect("hit_paddle", Callable($Player, "_on_hit_paddle"))
	
	
func _build_brick_grid() -> void:
	for row in range(brick_rows):
		var spawn_position = brick_spawn_start.position
		for col in range(brick_col):
			_spawn_brick(spawn_position, row)
			spawn_position.x += brick_col_spacing
		brick_spawn_start.position.y += brick_row_spacing
		
		
func _spawn_brick(spawn_position, row) -> void:
	var brick_instance = brick.instantiate()
	add_child(brick_instance)
	brick_instance.position = spawn_position
	brick_instance.speed_modifier = speed_modifiers[row]
	brick_instance.color_rect.color = brick_colors[row]


func _increment_score() -> void:
	if ui.has_method("_score"):
		ui._score()


func _on_win() -> void:
	area_bounds.queue_free()
	ui.ui_game_over(true)


func _on_area_bounds_body_entered(body: Node2D) -> void:
	audio_ball_missed.play()
	body.queue_free()
	if ui.decrement_ball() < 0:
		ui.ui_game_over(false)
	else:
		get_ready()
