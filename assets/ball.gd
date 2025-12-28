extends CharacterBody2D

signal hit_brick
signal hit_paddle

var current_speed_modifier = 1.0
var trail_queue: Array
var trail_length: int

@onready var trail: Line2D = %Trail
@onready var audio_hit_paddle: AudioStreamPlayer2D = $AudioHitPaddle
@onready var audio_hits: AudioStreamPlayer2D = $AudioHits


func _ready() -> void:
	var x_velocity = randf_range(25.0, 100.0) * sign(randf_range(-1.0, 1.0))
	velocity = Vector2(x_velocity, 250)
	trail_length = trail.max_length
	
	# audio stream randomizer
	var audio_fx_hits := AudioStreamRandomizer.new()
	audio_fx_hits.add_stream(0, preload("res://content/audio/square_held_high_ab.ogg"))
	audio_fx_hits.add_stream(1, preload("res://content/audio/square_held_high_f.ogg"))
	audio_fx_hits.add_stream(2, preload("res://content/audio/square_short_high_ab.ogg"))
	audio_fx_hits.add_stream(3, preload("res://content/audio/square_short_high_f.ogg"))
	audio_fx_hits.add_stream(4, preload("res://content/audio/square_mid_ab.ogg"))
	
	audio_hits.stream = audio_fx_hits
	
	
func _physics_process(delta: float) -> void:
	_trail()
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):
			_paddle_collision(collider, collision)
		elif collider.is_in_group("Ceiling"):
			velocity.y = -velocity.y
			audio_hits.play()
		elif collider.is_in_group("Brick"):
			_brick_collision(collider, collision)
		elif collider.is_in_group("Wall"):		
			velocity.x = -velocity.x
			audio_hits.play()


func _paddle_collision(collider, collision) -> void:
	velocity = _deflection_angle(collider, collision)
	emit_signal("hit_paddle")
	audio_hit_paddle.play()


func _brick_collision(collider, collision) -> void:
	emit_signal("hit_brick")
	velocity = _deflection_angle(collider, collision)
	velocity.y = -velocity.y
	var collider_speed_modifier = collider.speed_modifier
	if collider_speed_modifier > current_speed_modifier:
		velocity *= collider.speed_modifier
		current_speed_modifier = collider_speed_modifier
	collider.queue_free()
	audio_hits.play()


func _deflection_angle(collider, collision) -> Vector2:
	var center = collider.global_position.x
	var ball_pos = collision.get_position().x
	var distance_from_center = ball_pos - center
	var speed = velocity.length()
	velocity.y = -abs(velocity.y)
	velocity.x += distance_from_center * 5
	return velocity.normalized() * speed


func _trail() -> void:
	trail_queue.push_front(position)
	if trail_queue.size() > trail_length:
		trail_queue.pop_back()
	trail.clear_points()
	for point in trail_queue:
		trail.add_point(point)
	
