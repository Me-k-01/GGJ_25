extends RayCast3D
 
@onready var prompt = $Prompt 
 

func _physics_process(_delta): 
	prompt.text = ""
	if is_colliding():
		var collider = get_collider() 
		#if collider is Interactable:
		if collider.has_method("get_prompt") and collider.has_method("interact"):
			prompt.text = collider.get_prompt()
			
			if Input.is_action_just_pressed("interact") :
				collider.interact(owner)
