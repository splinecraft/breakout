extends CharacterBody2D

@export var speed := 200.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(100, 100)
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
	move_and_slide()
	
	if get_last_slide_collision():
		var collider = get_last_slide_collision().get_collider()
		if collider.is_in_group("Player") or collider.is_in_group("Ceiling"):			
			velocity.y = -velocity.y
		elif collider.is_in_group("Wall"):		
			velocity.x = -velocity.x
		
