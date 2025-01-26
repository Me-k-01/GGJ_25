extends Interactable

func _on_interacted(body):
	$AnimationPlayer.play("ladder-longAction")
