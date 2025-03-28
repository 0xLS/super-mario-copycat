extends Area2D

@export var speed = 600
var direction = Vector2.RIGHT

func _physics_process(delta):
	position += direction * speed * delta
	
func _ready():
	print("testestset")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		get_node("PlayerHit").play()
		queue_free()
