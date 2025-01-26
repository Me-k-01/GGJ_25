extends RigidBody3D

@export var lifetime = -1.0
@export var generation_time = 0.2
@export var shrinking_time = 1.0
@export var levitation_height := 2.90
@export var float_force := 5.0
@export var drag := 0.05
@export var angular_drag := 0.05
@export var is_hot_bubble := false


var start_y = 0.0
var generation_timer = 0.0
var lifetime_timer = 0.0
var submerged := false
var base_scale := Vector3.ZERO

func _ready() -> void :
	start_y = global_transform.origin.y
	lifetime_timer = lifetime
	base_scale = $"BubbleMesh".scale

func _process(delta : float) -> void :
	generation_timer += delta
	if generation_timer <= generation_time :
		$"BubbleMesh".scale = base_scale * generation_timer / generation_time
		$"BubbleCollision".scale = base_scale * generation_timer / generation_time
	if lifetime != -1 :
		lifetime_timer -= delta
		if lifetime_timer <= shrinking_time :
			$"BubbleMesh".scale = base_scale * lifetime_timer / shrinking_time
			$"BubbleCollision".scale = base_scale * lifetime_timer / shrinking_time
		if lifetime_timer <= 0 :
			queue_free()

func _physics_process(_delta: float) -> void:
	submerged = true
	
	var ground_height := 0
	var collider = $RayCast3D.get_collider()
	if collider != null :
		ground_height = $RayCast3D.get_collision_point().y + levitation_height
	if is_hot_bubble :
		ground_height = start_y
	
	var depth = ground_height - global_position.y
	var force = Vector3.ZERO
	if depth > 0 :
		submerged = true
		force = (- Vector3.UP * float_force * get_gravity() * depth)
		#if force.y > 20 : force.y = 20
	apply_central_force(force)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged :
		state.linear_velocity *= 1 - drag
		state.angular_velocity *= 1 - angular_drag

@warning_ignore("shadowed_variable_base_class")
func move(position):
	global_transform.origin = position
	start_y = position.y
