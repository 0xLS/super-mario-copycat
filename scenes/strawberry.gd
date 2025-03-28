extends Area2D

@onready var gameManager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if (body.name == 'CharacterBody2D'):
		get_node("../../../Coin").play()
		gameManager.addPoint()
		var tween = get_tree().create_tween() 
		var tween2 = get_tree().create_tween() 
		tween.tween_property(self, "position", position - Vector2(0, 35), 0.35) 
		tween2.tween_property(self, "modulate:a", 0, 0.2) 
		tween.tween_callback(queue_free)
