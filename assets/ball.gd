extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(100, 250)
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):			
			var paddle_center = collider.global_position.x
			var ball_pos = collision.get_position().x
			var distance_from_center = ball_pos - paddle_center
			
			var speed = velocity.length()
			velocity.y = -abs(velocity.y)
			velocity.x += distance_from_center * 5
			velocity = velocity.normalized() * speed
		elif collider.is_in_group("Ceiling"):
			velocity.y = -velocity.y
		elif collider.is_in_group("Wall"):		
			velocity.x = -velocity.x
		
