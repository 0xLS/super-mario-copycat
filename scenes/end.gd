extends Area2D

# pass in the current file name (e.g level1.tscn)
func isCurrentScene(scene: String):
	var currentScene = get_tree().current_scene
	return currentScene.scene_file_path.contains(scene)

func _on_body_entered(body: Node2D) -> void:
	if (body.name == 'CharacterBody2D'):
		if(isCurrentScene('level1')):
			get_tree().change_scene_to_file("res://scenes/level2.tscn")
