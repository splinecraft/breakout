extends StaticBody2D

var speed: float = 300.0



func _process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	position.x += direction * speed * delta
	
