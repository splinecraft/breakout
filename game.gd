extends Node2D

@export var player: CharacterBody2D

@onready var brick: PackedScene = preload("res://assets/brick.tscn")
@onready var test_marker: Marker2D = %test_marker

var brick_rows: int = 4
var brick_col: int = 12

var colors:Array[Color] = [
	Color.CRIMSON,
	Color.ORANGE,
	Color.WEB_GREEN,
	Color.YELLOW	
]

var speed_modifiers:Array[float] = [1.6, 1.4, 1.2, 1.0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_build_brick_grid()
	

func _build_brick_grid() -> void:
	for row in range(brick_rows):
		var spawn_position = test_marker.position
		for col in range(brick_col):
			_spawn_brick(spawn_position, row)
			spawn_position.x += 78
		test_marker.position.y += 22
		
func _spawn_brick(spawn_position, row) -> void:
	var brick_instance = brick.instantiate()
	add_child(brick_instance)
	brick_instance.position = spawn_position
	brick_instance.speed_modifier = speed_modifiers[row]
	brick_instance.color_rect.color = colors[row]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
