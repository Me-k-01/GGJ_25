extends ShapeCast3D

var player = null
@export var player_path : NodePath

func _ready() -> void:
	player = get_node(player_path)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click") :
		for i in range(get_collision_count()) :
			var collider = get_collider(i)
			if collider.is_in_group("bubble"):
				var force = (collider.global_transform.origin - player.global_transform.origin)
				#force = Vector3(force.x, 0, force.z)
				force = force.normalized() * 100
				collider.apply_central_force(force)
