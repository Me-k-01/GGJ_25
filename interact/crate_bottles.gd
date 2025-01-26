extends "res://interact/interactable.gd"

var map = null
var instance = null
 
@export var map_path : NodePath
@export var bubble = load("res://scenes/bubbles/water_bubble.tscn")

@export var agents : Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	map = get_node(map_path) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
  
func add_to_all_agent(instance) :  
	for i in get_tree().get_nodes_in_group("agents") : 
		i.bubble = instance

func _on_interacted(body: Variant) -> void:  
	print(global_transform.origin)
	if instance != null :
		instance.pop()
		#instance.lifetime_timer = instance.shrinking_time
		#instance.pop_front()
	
	instance = bubble.instantiate()
	add_to_all_agent(instance)
	#instance.move(global_transform.origin)
	#map.add_child(instance)
	add_child(instance) 
	instance.global_position = self.global_position
	print(instance)
