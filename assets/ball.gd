extends CharacterBody2D

signal hit_brick
@onready var particle_tail: CPUParticles2D = $ParticleTail

var current_speed_modifier = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x_velocity = randf_range(25.0, 100.0) * sign(randf_range(-1.0, 1.0))
	velocity = Vector2(x_velocity, 250)
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):			
			_paddle_collision(collider, collision)
		elif collider.is_in_group("Ceiling"):
			velocity.y = -velocity.y
		elif collider.is_in_group("Brick"):
			_brick_collision(collider)
		elif collider.is_in_group("Wall"):		
			velocity.x = -velocity.x
	

func _paddle_collision(collider, collision) -> void:
	var paddle_center = collider.global_position.x
	var ball_pos = collision.get_position().x
	var distance_from_center = ball_pos - paddle_center
	
	var speed = velocity.length()
	velocity.y = -abs(velocity.y)
	velocity.x += distance_from_center * 5
	velocity = velocity.normalized() * speed

func _brick_collision(collider) -> void:
	emit_signal("hit_brick")
	velocity.y = -velocity.y
	var collider_speed_modifier = collider.speed_modifier
	if collider_speed_modifier > current_speed_modifier:
		velocity *= collider.speed_modifier
		current_speed_modifier = collider_speed_modifier
	collider.queue_free()
