extends "res://interact/interactable.gd"
 
#@onready var animPlayer = $AnimationPlayer 
@export var animPlayer:AnimationPlayer 
 


func _on_interacted(body: Variant) -> void:
	print(animPlayer)
	animPlayer.play("ladder-longAction")
