extends Node3D

var map = null
@export var map_path : NodePath

var air_bubble = load("res://scenes/bubbles/air_bubble.tscn")

func _ready() -> void:
	map = get_node(map_path)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("right_click") :
		var instance = air_bubble.instantiate()
		map.add_child(instance)
		instance.global_transform.origin = global_transform.origin
