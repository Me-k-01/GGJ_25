extends StaticBody3D

var map = null
@export var map_path : NodePath
@export var max_bubbles := 1
@export var cooldown := 5
@export var bubble_lifetime := 4
@export var delay := 10.0
@export var power := 200

var is_on_cooldown = false
var timer = 0.0
var delay_timer = 0.0

var air_bubble = load("res://scenes/bubbles/hot_air_bubble.tscn")
var air_bubbles = []
var new_air_bubbles = []

func _ready() -> void:
	map = get_node(map_path)
	timer = cooldown
	delay_timer = delay

func _process(delta: float) -> void:
	delay_timer -= delta
	if delay_timer <= 0 :
		delay_timer = 0
		timer -= delta
		if timer <= 0 : is_on_cooldown = false
		if !is_on_cooldown :
			var instance = air_bubble.instantiate()

			instance.lifetime = bubble_lifetime
			map.add_child(instance)
			instance.move($"SpawnPosition".global_transform.origin)
			var force = (instance.global_transform.origin - global_transform.origin)
			#force = Vector3(force.x, 0, force.z)
			force = force.normalized() * power
			instance.apply_central_force(force)

			is_on_cooldown = true
			timer = cooldown

			air_bubbles.append(instance)
			new_air_bubbles = []
			for i in range(air_bubbles.size()) :
				if is_instance_valid(air_bubbles[i]) :
					new_air_bubbles.append(air_bubbles[i])
			air_bubbles = new_air_bubbles

			if air_bubbles.size() > max_bubbles :
				instance = air_bubbles[0]
				instance.timer = instance.shrinking_time
				air_bubbles.pop_front()
