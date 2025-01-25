extends Node

##################################
##### THIS IS CHAT GPT TRASH #####
##################################

#func _ready():
	#randomize_depth_biases() 
	#
#func randomize_depth_biases():
	#for child in get_tree().get_nodes(): 
		#if child.has_material_override():
			#var material = child.material_override
			#if material is StandardMaterial3D:
				#pass
				##material.depth_bias = randf() * 0.01 # Random bias between 0 and 0.01
		#elif child.get_surface_material_count() > 0:
			#for i in range(child.get_surface_material_count()):
				#var material = child.get_surface_material(i)
				#if material is StandardMaterial3D:
					#pass
					##material.depth_bias = randf() * 0.01
 
func _ready():
	apply_random_bias_to_tree(get_tree().root) # Start traversal from the root node

func apply_random_bias_to_tree(node):
	# Check if the current node is a MeshInstance3D
	if node is MeshInstance3D:
		# Ensure the mesh exists before trying to access its surfaces
		if node.mesh:
			# Duplicate the mesh to ensure unique changes for this instance
			var new_mesh = node.mesh.duplicate()
			
			# Loop through each surface of the mesh
			for surface_index in range(new_mesh.get_surface_count()):
				var material = new_mesh.surface_get_material(surface_index)
				if material is StandardMaterial3D:
					# Duplicate the material to avoid affecting other instances
					var new_material = material.duplicate()
					new_material.depth_bias = randf() * 0.1 # Random bias between 0 and 0.01
					new_mesh.surface_set_material(surface_index, new_material)

			# Assign the new mesh with updated materials back to the MeshInstance3D
			node.mesh = new_mesh

		# Handle material_override if present
		if node.material_override:
			if node.material_override is StandardMaterial3D:
				var overridden_material = node.material_override.duplicate()
				overridden_material.depth_bias = randf() * 0.1
				node.material_override = overridden_material

	# Recursively apply to all child nodes
	for child in node.get_children():
		apply_random_bias_to_tree(child)
