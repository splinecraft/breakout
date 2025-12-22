extends Control

@onready var score_label: RichTextLabel = %ScoreLabel
@onready var balls_remaining: RichTextLabel = %BallsRemaining
@onready var ready_label: Label = $ReadyLabel

var score: int = 0
var balls: int = 3


func _ready() -> void:
	balls_remaining.text = str(balls)

func _score() -> void:
	score += 1
	score_label.text = str(score)
	
func decrement_ball() -> int:
	balls -= 1
	balls_remaining.text = str(balls)
	return balls
	
func ui_get_ready() -> void:
	ready_label.show()

func ui_game_ip() -> void:
	ready_label.hide()
