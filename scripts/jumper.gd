extends ShapeCast3D

var time_between_jump = 0.05
var timer := 0.0

var is_double_jumping = false

func _ready() -> void:
	timer = time_between_jump

func _process(delta: float) -> void:
	if $"../../.".is_on_floor() : is_double_jumping = false
	timer -= delta
	
	if timer <= 0 :
		timer = 0
		for i in range(get_collision_count()) :
			var collider = get_collider(i)
			if collider.is_in_group("air_bubble") :
				if is_double_jumping : $"../../.".jump(2.25)
				else : $"../../.".jump(1.5)
				
				is_double_jumping = true
				timer = time_between_jump
				collider.queue_free()
