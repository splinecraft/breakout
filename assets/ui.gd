extends Control

signal win

@onready var score_label: RichTextLabel = %ScoreLabel
@onready var balls_remaining: RichTextLabel = %BallsRemaining
@onready var ready_label: Label = $ReadyLabel
@onready var game_over_label: Label = $GameOverLabel
@onready var play_again_btn: Button = $GameOverLabel/PlayAgainUI/HBoxContainer/PlayAgainBtn
@onready var quit_btn: Button = $GameOverLabel/PlayAgainUI/HBoxContainer/QuitBtn

var score: int = 0
var balls: int = 3


func _ready() -> void:
	balls_remaining.text = str(balls)
	game_over_label.hide()
	play_again_btn.pressed.connect(restart)
	quit_btn.pressed.connect(quit)

func _score() -> void:
	score += 1
	score_label.text = str(score)
	if score == 48:
		emit_signal("win")
	
func decrement_ball() -> int:
	balls -= 1
	if balls >= 0:
		balls_remaining.text = str(balls)
	return balls
	
func ui_get_ready() -> void:
	ready_label.show()

func ui_game_ip() -> void:
	ready_label.hide()
	
func ui_game_over(won_game) -> void:
	if won_game:
		game_over_label.text = "Well done!"
	else:
		game_over_label.text = "Game Over"
	game_over_label.show()

func restart() -> void:
	get_tree().reload_current_scene()
	
func quit() -> void:
	get_tree().quit()
