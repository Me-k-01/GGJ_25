extends CharacterBody3D

var speed = 2

@export var bubble : Node = null
#var position = null
#@export var bubble_path : NodePath

@onready var navigation_agent = $NavigationAgent3D
 

func _process(delta: float) -> void:
	velocity = Vector3.ZERO 
	
	if bubble == null :
		# no target
		return
	#var pos = bubble.global_position # target
		
	navigation_agent.set_target_position(bubble.global_position)
	velocity += (navigation_agent.get_next_path_position() - global_position).normalized() * speed
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	look_at(bubble.global_transform.origin, Vector3.UP)
	rotation.x = 0
	rotation.z = 0
	move_and_slide()
