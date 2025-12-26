extends Node2D

@onready var space: Parallax2D = $Space
@onready var far_stars: Parallax2D = $FarStars
@onready var close_stars: Parallax2D = $CloseStars


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	space.scroll_offset.y -= 3 * delta
	far_stars.scroll_offset.y -= 9 * delta
	close_stars.scroll_offset.y -= 15 * delta
