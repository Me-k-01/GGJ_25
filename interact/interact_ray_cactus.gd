extends RayCast3D
 
#@onready var prompt = $Prompt 
 

func _physics_process(_delta):  
	if is_colliding(): 
		var collider = get_collider() 
		#if collider is Interactable:
		if collider.has_method("pop")  : 
			collider.pop() 
			#$Cactus.bubble = null
