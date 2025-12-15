# clamps a node's position so it can't move beyond the screen (plus a buffer
# border if desired
class_name ScreenClampComponent
extends Node2D

# The node whose position will be clamped
@export var node: Node2D

# a margin for the borders
@export var margin := 8

var left_border = 0
var right_border = ProjectSettings.get_setting("display/window/size/viewport_width")

func _process(delta: float) -> void:
	# clamp the x position between the borders, accounting for the margin
	node.global_position.x = clamp(node.global_position.x, left_border+margin, right_border-margin)
