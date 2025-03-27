extends RigidBody2D

@onready var gameManager: Node = %GameManager

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == 'CharacterBody2D'):
		var y_delta = position.y - body.position.y
		if(y_delta > 30):
			queue_free()
			body.jump()
		else:
			gameManager.decreaseHealth()
