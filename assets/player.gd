extends StaticBody2D

var speed: float = 350.0


func _process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	position.x += direction * speed * delta
