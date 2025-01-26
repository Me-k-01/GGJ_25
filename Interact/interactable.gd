extends CollisionObject3D
class_name Interactable

@export var prompt_message = "Interact"
@export var prompt_input = "Interact"

func interact(body):
	print(body.name, " interact with ", name)
