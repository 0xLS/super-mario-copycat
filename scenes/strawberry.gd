extends Area2D

@onready var gameManager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if (body.name == 'CharacterBody2D'):
		queue_free()
		gameManager.addPoint()
