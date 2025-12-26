extends StaticBody2D

var speed: float = 350.0
@onready var sprite_anim: AnimatedSprite2D = %SpriteAnim



func _process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	position.x += direction * speed * delta

func _on_hit_paddle() -> void:
	sprite_anim.play("impact")
	
