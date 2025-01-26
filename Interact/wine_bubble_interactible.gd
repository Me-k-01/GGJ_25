extends "res://Interact/interactable.gd"

var map = null
var instance = null
 
@export var map_path : NodePath
@export var bubble = load("res://scenes/bubbles/water_bubble.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	map = get_node(map_path) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
  

func _on_interacted(body: Variant) -> void:  
	print("test")
	if instance != null :
		instance.lifetime_timer = 1
		#instance.lifetime_timer = instance.shrinking_time
		#instance.pop_front()
	
	instance = bubble.instantiate()
	map.add_child(instance)
