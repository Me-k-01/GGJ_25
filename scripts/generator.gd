extends Node3D

var map = null
@export var map_path : NodePath
@export var max_bubbles := 4
@export var cooldown := 0.8

var is_on_cooldown = false
var timer = 0.0

var air_bubble = load("res://scenes/bubbles/air_bubble.tscn")
var air_bubbles = []
var new_air_bubbles = []

func _ready() -> void:
	map = get_node(map_path)
	timer = cooldown

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0 : is_on_cooldown = false
	if !is_on_cooldown :
		if Input.is_action_just_pressed("right_click") :
			var instance = air_bubble.instantiate()
			map.add_child(instance)
			instance.move(global_transform.origin)
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
				instance.lifetime_timer = instance.shrinking_time
				air_bubbles.pop_front()
				
