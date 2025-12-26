extends StaticBody2D

var speed: float = 350.0
@onready var sprite_anim: AnimatedSprite2D = %SpriteAnim


func _process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	position.x += direction * speed * delta

func _on_hit_paddle() -> void:
	sprite_anim.play("impact")
	var tween = create_tween()
	var duration_enter: float = 0.05
	var duration_exit: float = 0.125
	tween.tween_property(sprite_anim, "scale:x", 0.8, duration_enter)
	tween.tween_property(sprite_anim, "scale:x", 1.0, duration_exit)
	
