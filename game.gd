extends Node2D

@export var player: CharacterBody2D

@onready var brick: PackedScene = preload("res://assets/brick.tscn")
@onready var test_marker: Marker2D = %test_marker

var brick_rows: int = 4
var brick_col: int = 12

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_build_brick_grid()
	

func _build_brick_grid() -> void:
	for row in range(brick_rows):
		var spawn_position = test_marker.position
		for col in range(brick_col):
			_spawn_brick(spawn_position)
			spawn_position.x += 78
		test_marker.position.y += 22
		
func _spawn_brick(spawn_position) -> void:
	var brick_instance = brick.instantiate()
	add_child(brick_instance)
	brick_instance.position = spawn_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
