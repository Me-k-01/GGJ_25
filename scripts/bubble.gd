extends RigidBody3D

@export var levitation_height := 2.90
@export var float_force := 5.0
@export var drag := 0.05
@export var angular_drag := 0.05

var submerged := false

func _physics_process(_delta: float) -> void:	
	submerged = true
	
	var ground_height := 0
	var collider = $RayCast3D.get_collider()
	if collider != null :
		ground_height = collider.global_position.y + levitation_height
	
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
